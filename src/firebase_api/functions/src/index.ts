import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { workers } from './workers';

admin.initializeApp();
const db = admin.firestore();

export const taskRunner = functions
  .runWith({ memory: "2GB" })
  // .pubsub.schedule('* * * * *') // Every minute
  // .pubsub.schedule('*/30 * * * *') // Every 30 minutes
  .pubsub.schedule("0 0 * * *") // Once a day
  .onRun(async (context) => {
    console.log("Starting taskRunner");

    const now = admin.firestore.Timestamp.now();

    console.log("Fetching notifications to be sent based on this time" + now);

    const query = db
      .collection("tasks")
      .where("performAt", "<=", now)
      .where("status", "==", "scheduled");

    const tasks = await query.get();
    const jobs: Promise<any>[] = [];

    tasks.forEach((snapshot) => {
      const { worker, options } = snapshot.data();
      const job = workers[worker](options)
        .then(() => {
          console.log("Setting complete state at database");
          snapshot.ref.update({
            status: "complete",
          });
        })
        .catch((_) => {
          console.log("Setting error state at database");
          snapshot.ref.update({
            status: "error",
          });
        });

      jobs.push(job);
    });

    return await Promise.all(jobs);
  });

export const onEventCreate = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onCreate(async (snapshot, context) => {
    console.log("Starting onEventCreate function");

    const ref = snapshot.ref;
    const userRef = ref.parent.parent;
    if (userRef == null) {
      console.log("userRref is null, stopping process");
      return;
    }

    const userQuery = await userRef.get();
    const user = userQuery.data();
    const event = snapshot.data();
    if (user == null) {
      console.log("user is null, stopping process");
      return;
    }

    await db
      .collection("tasks")
      .doc()
      .set({
        worker: "sendPushNotification",
        status: "scheduled",
        performAt: event.starTime,
        options: {
          eventId: context.params.eventId,
          userId: context.params.userId,
          username: user.username,
        },
      });

    console.log("Finishing onEventCreate function");
  });

export const onEventUpdate = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onUpdate(async (change, context) => {
    console.log("Starting onEventUpdate function");

    const eventId = context.params.eventId;

    const taskRef = db.collection("tasks");
    const snapshot = await taskRef
      .where("options.eventId", "==", eventId)
      .get();

    if (snapshot.docs.length == 0) {
      console.log("Finishing onEventUpdate withou task updates");
      return;
    }

    await db.collection("tasks").doc(snapshot.docs[0].id).update({
      performAt: change.after.data().starTime,
      status: "scheduled",
    });

    console.log("Finishing onEventUpdate function");
  });

export const onEventDelete = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onDelete(async (_, context) => {
    console.log("Starting onEventDelete function");
    const eventId = context.params.eventId;

    const taskRef = db.collection("tasks");
    const snapshot = await taskRef
      .where("options.eventId", "==", eventId)
      .get();

    if (snapshot.docs.length == 0) {
      console.log("Finishing onEventDelete without task deletion");
      return;
    }

    await db.collection("tasks").doc(snapshot.docs[0].id).delete()
  });