import { Router } from 'express'
import EventController from './controllers/event_controller'
import UserController from './controllers/user_controller'

const routes = Router()

routes.post('/user/:id/logout', UserController.logout)
routes.post('/user/:id/token', UserController.registerToken)
routes.post('/user/:id/topics', UserController.updateTopics)
routes.post('/user/:username/event', EventController.create)

export default routes