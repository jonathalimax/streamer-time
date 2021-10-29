import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

admin.initializeApp();
const db = admin.firestore();

interface Workers {
    [key: string]: (options: any) => Promise<any>;
}

const workers: Workers = {
    sendPushNotification: async ({ userId, eventId, username }) => {
        const query = db.collection('users').doc(userId).collection('events').doc(eventId);
        const snapshot = await query.get();
        const data = snapshot.data();

        if (data == null) return;

        const { title, categoryName } = data;
        console.log('Starting notification sending with title: ' + title + ' and category name: ' + categoryName);

        return admin.messaging().sendToTopic(username, {
            notification: {
                title: title,
                body: username + ' está transmitindo ' + categoryName,
                sound: "default",
            },
        },
            {
                timeToLive: 14400,
            });
    }
};

export const taskRunner = functions
    .runWith({
        memory: '2GB',
    })
    .pubsub
    .schedule('0 0 * * *')
    // .schedule('* * * * *')
    .onRun(async context => {
        console.log('Starting taskRunner');

        const now = admin.firestore.Timestamp.now();
        const query = db
            .collection('tasks')
            .where('performAt', '<=', now)
            .where('status', '==', 'scheduled');

        const tasks = await query.get();
        const jobs: Promise<any>[] = [];

        tasks.forEach(snapshot => {
            const { worker, options } = snapshot.data();
            const job = workers[worker](options)
                .then(() => {
                    console.log('Setting complete state at database');
                    snapshot.ref.update({
                        status: 'complete',
                    })
                })
                .catch(_ => {
                    console.log('Setting error state at database');
                    snapshot.ref.update({
                        status: 'error',
                    })
                });

            jobs.push(job);
        });

        return await Promise.all(jobs);
    });

export const onEventCreate = functions
    .firestore
    .document('users/{userId}/{eventCollectionId}/{eventId}')
    .onWrite(async (change, context) => {
        console.log('Starting onEventCreate function');

        const data = change.after.data();
        if (data == null) return;
        
        await db
            .collection('tasks')
            .doc()
            .set({
                worker: 'sendPushNotification',
                status: 'scheduled',
                performAt: data.starTime,
                options: {
                    eventId: context.params.eventId,
                    userId: context.params.userId,
                    username: 'gaules', // TODO: get username from user
                }
            });

        console.log('Finishing onEventCreate function');
    });