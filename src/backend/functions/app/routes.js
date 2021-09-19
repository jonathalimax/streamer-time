import express from 'express';
import AgendaController from '../src/controllers/agenda_controller.js';
import EventController from '../src/controllers/event_controller.js';
import ScheduleController from '../src/controllers/schedule_controller.js';
import StreamerController from '../src/controllers/streamer_controller.js';
import UserController from '../src/controllers/user_controller.js';

const routes = new express.Router();

// Agenda
routes.get('/agenda', AgendaController.get);
routes.get('/agendas', AgendaController.getAll);
routes.get('/agenda/:streamerid', AgendaController.getByStreamerId);

// Event
routes.post('/event', EventController.create);
routes.patch('/event', EventController.update);
routes.delete('/event', EventController.delete);

// Schedule
routes.get('/schedule', ScheduleController.get);
routes.post('/schedule', ScheduleController.create);
routes.patch('/schedule', ScheduleController.update);
routes.delete('/schedule', ScheduleController.delete);

// Streamer
routes.post('/streamer/follow', StreamerController.follow);
routes.post('/streamer/unfollow', StreamerController.unfollow);
routes.get('/streamer/followed', StreamerController.getFollowed);
routes.get('/streamer/following', StreamerController.getFollowing);

// User
routes.get('/user', UserController.get);
routes.patch('/user', UserController.create);
routes.put('/user', UserController.update);

export default routes;