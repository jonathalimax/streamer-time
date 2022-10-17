import * as admin from 'firebase-admin'
import * as functions from "firebase-functions"
import { workers } from './Workers'

type Context = functions.EventContext
const database = admin.firestore()

class Runner {
    public async taskRunner(context: Context) {
        console.log("Starting taskRunner")

        const now = admin.firestore.Timestamp.now()
        const query = database
            .collection("tasks")
            .where("performAt", "<=", now)
            .where("status", "==", "scheduled")

        const tasks = await query.get()
        const jobs: Promise<any>[] = []

        tasks.forEach((snapshot) => {
            const { worker, options } = snapshot.data()
            const job = workers[worker](options)
                .then(() => {
                    console.log("Setting task status as completed")

                    snapshot.ref.update({
                        status: "complete",
                    })
                })
                .catch((_) => {
                    console.log("Setting task status as error")

                    snapshot.ref.update({
                        status: "error",
                    })
                })

            jobs.push(job)
        })

        return await Promise.all(jobs)
    }
}

export default new Runner()