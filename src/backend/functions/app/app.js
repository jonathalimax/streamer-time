import express from "express";
import routes from "./routes.js";

class App {
  constructor() {
    this.server = express();
    this.middlewares();
    this.home();
    this.routes();
    this.exceptionHandler();
  }

  home() {
    this.server.get('/', (req, res) => res.send('Welcome to Streamertime API'));
  }

  middlewares() {
    this.server.use(express.json());
  }

  routes() {
    this.server.use(routes);
  }

  exceptionHandler() {
    this.server.use(async (err, req, res, next) => {
      return res.status(500).json({ error: "Ocorreu um erro interno!" });
    });
  }
}

export default new App().server;
