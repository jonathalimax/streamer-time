import { Router } from 'express'
import EventController from './controllers/event_controller'
import UserController from './controllers/user_controller'

const routes = Router()

routes.post('/user/:username/event', EventController.create)
routes.post('/user/:id/token', UserController.registerToken)
routes.delete('/user/:id/token', UserController.unregisterToken)
routes.post('/user/:id/topics', UserController.updateTopics)
routes.delete('/user/:id/topics', UserController.unsubscribeTopics)

export default routes