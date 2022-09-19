import * as admin from "firebase-admin";

interface Workers {
    [key: string]: (options: any) => Promise<any>;
}

export const workers: Workers = {
    sendPushNotification: async ({ userId, eventId, username }) => {
      const query = admin.firestore()
        .collection("users")
        .doc(userId)
        .collection("events")
        .doc(eventId);
  
      const snapshot = await query.get();
      const data = snapshot.data();
  
      if (data == null) return;
  
      const { title, categoryName } = data;
      console.log(
        "Starting notification sending with title: " + title +
        " and category name: " + categoryName +
        " to topic: " + username
      );
  
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
          timeToLive: 43200, // 12 hours
          contentAvailable: true,
          dryRun: true, // TODO: Undo this configuration
          priority: 'high',
        }
      );
    },
  };