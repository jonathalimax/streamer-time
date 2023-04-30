import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import * as express from 'express'

type Snapshot = functions.firestore.QueryDocumentSnapshot
type Context = functions.EventContext
type Change = functions.Change<functions.firestore.QueryDocumentSnapshot>

const database = admin.firestore()

class EventController {
    public async create(req: express.Request, res: express.Response) {
        const username = req.params.username;

        try {
            const snapshot = await database
                .collection('users')
                .where('username', '==', username)
                .get();

            if (snapshot.empty) {
                return res.status(204).send(`No streamer found with this username: ${username}. 😅`);
            }

            const result = await database
                .collection('users')
                .doc(snapshot.docs[0].id)
                .collection('events')
                .doc()
                .set(req.body);

            if (result == null) {
                return res.status(500).send(`Something goes wrong!`);
            }

            return res.status(200).send('Event inserted successfully 🫡');

        } catch (error) {
            res.status(500).send(`Something goes wrong! ${error}`);
        }
    }

    public async onEventCreate(snapshot: Snapshot, context: Context) {
        console.log('Starting onEventCreate function')

        const ref = snapshot.ref
        const userRef = ref.parent.parent
        if (userRef == null) {
            console.log('userRref is null, stopping process')
            return
        }

        const userQuery = await userRef.get()
        const user = userQuery.data()
        const event = snapshot.data()
        if (user == null) {
            console.log('user is null, stopping process')
            return
        }

        await database
            .collection('tasks')
            .doc()
            .set({
                worker: 'sendPushNotification',
                status: 'scheduled',
                performAt: event.starTime,
                options: {
                    eventId: context.params.eventId,
                    userId: context.params.userId,
                    username: user.username,
                },
            })

        console.log('Finishing onEventCreate function')
    }

    public async onEventUpdate(change: Change, context: Context) {
        const eventId = context.params.eventId

        const snapshot = await database
            .collection('tasks')
            .where('options.eventId', '==', eventId)
            .get()

        if (snapshot.docs.length == 0) {
            console.log('Finishing onEventUpdate without task updates')
            return
        }

        await database
            .collection('tasks')
            .doc(snapshot.docs[0].id)
            .update({
                performAt: change.after.data().starTime,
                status: 'scheduled',
            })

        console.log('Finishing onEventUpdate function')
    }

    public async onEventDelete(snapshot: Snapshot, context: Context) {
        const eventId = context.params.eventId
        const result = await database
            .collection('tasks')
            .where('options.eventId', '==', eventId)
            .get()

        if (result.docs.length == 0) {
            console.log('Finishing onEventDelete without task deletion')
            return
        }

        await database
            .collection('tasks')
            .doc(result.docs[0].id)
            .delete()

        console.log('Task deleted succesfully')
    }
}

export default new EventController()