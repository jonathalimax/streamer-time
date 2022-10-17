import { Router } from 'express'
import EventController from './controllers/eventController'

const routes = Router()

routes.post('/user/:username/event', EventController.create)

export default routes