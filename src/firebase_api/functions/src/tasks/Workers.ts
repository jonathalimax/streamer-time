import * as admin from "firebase-admin"
import { randomTitle } from '../utils/push_info'

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

    return admin.messaging().send({
      topic: username,
      notification: {
        title: username + ` ${randomTitle}`,
        body: title,
      },
      android: {
        ttl: 14400, // 4 hours,
        notification: {
          imageUrl: imageUrl,
          priority: 'high',
          notificationCount: 0,
          defaultSound: true
        }
      },
      apns: {
        payload: {
          aps: {
            mutableContent: true,
            badge: 0,
            sound: 'default',
            threadId: username,
          }
        },
        fcmOptions: {
          imageUrl: imageUrl
        },
      },
      data: {
        'type': 'live',
        'streamerId': userId,
        'username': username
      }
    });
  },
}