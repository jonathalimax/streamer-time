import * as admin from 'firebase-admin'
import * as express from 'express'
import { FieldValue } from 'firebase-admin/firestore'

const database = admin.firestore()

class UserController {
    public async logout(req: express.Request, res: express.Response) {
        try {
            const deviceToken: string = req.body.deviceToken

            // Unregister user deviceToken
            await database
                .collection('users')
                .doc(req.params.id)
                .update({ deviceToken: FieldValue.arrayRemove(deviceToken) })

            // Fetch subscribed topics
            const streamers = await database
                .collection('users')
                .doc(req.params.id)
                .collection('following')
                .get()

            // Unsubscribe from topics
            for (const streamer of streamers.docs) {
                const topic = streamer.get('username')
                console.log(`Unsubscribing topic: ${topic} for deviceToken: ${deviceToken}`)
                await admin.messaging().unsubscribeFromTopic(deviceToken, topic)
            }

            console.log(`Logged out successfully 🫡`)
            return res.status(200).send(`Logged out successfully 🫡`)

        } catch (error) {
            return res.status(500).send(`Something goes wrong! ${error}`);
        }
    }

    public async registerToken(req: express.Request, res: express.Response) {
        try {
            const deviceToken = req.body.deviceToken

            await database
                .collection('users')
                .doc(req.params.id)
                .update({
                    deviceToken: FieldValue.arrayUnion(deviceToken)
                })

            return res.status(200).send(`Device token was successfully updated`);

        } catch (error) {
            return res.status(500).send(`Something goes wrong! ${error}`);
        }
    }

    public async updateTopics(req: express.Request, res: express.Response) {
        try {
            const user = await database
                .collection('users')
                .doc(req.params.id)
                .get()

            const deviceToken: [string] = user.get('deviceToken')

            if (deviceToken == undefined)
                return res.status(500).send(`The device token is missing for this user! 💩`)

            const streamers = await database
                .collection('users')
                .doc(req.params.id)
                .collection('following')
                .get()

            if (streamers.docs.length == 0)
                return res.status(200).send(`There is no topic to update 😅`)

            for (const streamer of streamers.docs) {
                const topic = streamer.get('username')
                await admin.messaging().subscribeToTopic(deviceToken, topic)
            }

            return res.status(200).send(`All topics were successfully updated 🫡`)

        } catch (error) {
            return res.status(500).send(`Something goes wrong! ${error}`);
        }
    }
}

export default new UserController()