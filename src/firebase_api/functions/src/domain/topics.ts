import * as admin from 'firebase-admin'

class Topics {
    database: any

    constructor() {
        this.database = admin.firestore()
    }

    async updateTopics(userId: string) {
        const query = this.database
                .collection('users')
                .doc(userId)

            const user = await query.get()
            const deviceTokens: string[] = user.get('deviceToken')

            if (Array.isArray(deviceTokens) && deviceTokens.length == 0)
                throw new Error(`The device token is missing for this user! 💩`)

            const streamers = await this.database
                .collection('users')
                .doc(userId)
                .collection('following')
                .get()

            if (streamers.docs.length == 0)
                return console.log(`There is no topic to update 😅`)
            
            for (const streamer of streamers.docs) {
                const topic = streamer.get('username')
                await admin.messaging().subscribeToTopic(deviceTokens, topic)
            }

            console.log(`Updating topics timestamp`)

            // Update topics update timestamp
            await query.update({ topicsUpdatedAt: admin.firestore.Timestamp.now() })
    }
}

export default new Topics()