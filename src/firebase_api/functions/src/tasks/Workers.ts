import * as admin from "firebase-admin"
import { randomTitle } from '../push_info'

interface Workers {
  [key: string]: (options: any) => Promise<any>
}

export const workers: Workers = {
  sendPushNotification: async ({ userId, eventId, username }) => {
    const snapshot = await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .collection("events")
      .doc(eventId)
      .get();

    const data = snapshot.data()
    if (data == null) return

    const { title, imageUrl } = data

    return admin.messaging().sendToTopic(
      username,
      {
        notification: {
          title: username + ` ${randomTitle}`,
          body: title,
          sound: "default",
          badge: '0',
          image: imageUrl
        },
        data: {
          'type': 'live',
          'streamerId': userId,
          'username': username
        }
      },
      {
        timeToLive: 14400, // 4 hours
        contentAvailable: true,
        priority: 'high',
      }
    )
  },
}