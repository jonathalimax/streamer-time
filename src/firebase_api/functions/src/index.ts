import * as admin from "firebase-admin"
import * as functions from "firebase-functions"
import * as express from 'express'
import * as cors from 'cors'

admin.initializeApp()

import routes from './routes'
import Runner from './tasks/Runner'
import Schedules from './utils/schedules'
import EventController from "./controllers/event_controller"

const app = express();
const projectId = JSON.parse(process.env.FIREBASE_CONFIG ?? '').projectId;

app.use(cors({ origin: true }))
app.use(routes)

// Export endpoints
export const api = functions.https.onRequest(app);

export const taskRunner = functions
  .runWith({ memory: "128MB", minInstances: projectId === 'streamertime-app' ? 0 : 0 }) // Set 5 to reduce the cold starts
  .pubsub.schedule(Schedules.onceADay)
  .onRun(Runner.taskRunner)

export const onEventCreate = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onCreate(EventController.onEventCreate)

export const onEventUpdate = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onUpdate(EventController.onEventUpdate)

export const onEventDelete = functions.firestore
  .document("users/{userId}/{eventCollectionId}/{eventId}")
  .onDelete(EventController.onEventDelete)