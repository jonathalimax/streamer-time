import admin from "firebase-admin";
import app from "./app/app.js";
import functions from "firebase-functions";

admin.initializeApp();

export const streamertimeapi = functions.https.onRequest(app);