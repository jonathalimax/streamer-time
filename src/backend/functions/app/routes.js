import express from 'express';
import StreamerController from '../src/controllers/streamer-controller.js';

const routes = new express.Router();

routes.post('/saveStreamer/:user', StreamerController.favorite);

export default routes;