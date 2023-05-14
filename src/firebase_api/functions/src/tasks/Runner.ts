import * as firebase from 'firebase-admin'
import * as functions from "firebase-functions"
import { workers } from './Workers'
import topics from "../domain/topics"
import { Timestamp } from 'firebase-admin/firestore'

type Context = functions.EventContext
const database = firebase.firestore()

class Runner {
    public async taskRunner(context: Context) {
        console.log('Starting taskRunner')

        const query = database
            .collection('tasks')
            .where('performAt', '<=', Timestamp.now())
            .where('status', '==', 'scheduled')

        const tasks = await query.get()
        const jobs: Promise<any>[] = []

        tasks.forEach((snapshot) => {
            const { worker, options } = snapshot.data()
            const job = workers[worker](options)
                .then(() => {
                    console.log('Setting task status as completed')
                    snapshot.ref.update({ status: 'complete' })
                })
                .catch((error) => {
                    console.log(`Setting task status as error ${error}`)
                    snapshot.ref.update({ status: 'error' })
                })

            jobs.push(job)
        })

        return await Promise.all(jobs)
    }

    public async updateTopicsTask(context: Context) {
        console.log('Starting update topics task')
        const expirationDate = Timestamp.now().toDate()
        expirationDate.setDate(expirationDate.getDate() - 30)

        const snapshot = await database
            .collection('users')
            .where('topicsUpdatedAt', '<=', Timestamp.fromDate(expirationDate))
            .get()

        if (snapshot.docs.length == 0)
            return console.log(`There is no topics to update 😅`)

        await Promise.all(snapshot.docs.map(async doc => {
            const user = doc.data()
            console.log(`Update topics from ${user.name}, id: ${user.id}`)
            await topics.updateTopics(user.id)
        }))

        return console.log(`Finishing update topic task!`)
    }
}

export default new Runner()