import * as admin from "firebase-admin"

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
  
      const { title, categoryName } = data
      console.log(
        "Starting notification sending with title: " + title +
        " and category name: " + categoryName +
        " to topic: " + username
      )
  
      return admin.messaging().sendToTopic(
        username,
        {
          notification: {
            title: username + " está transmitindo " + categoryName,
            body: title,
            sound: "default",
            
          },
        },
        {
          timeToLive: 14400, // 4 hours
          contentAvailable: true,
          priority: 'high',
        }
      )
    },
  }