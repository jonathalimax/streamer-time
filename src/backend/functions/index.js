import app from "./app/app.js";
import functions from "firebase-functions";

export const streamertimeapi = functions.https.onRequest(app);