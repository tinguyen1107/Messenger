const userRouter = require('./user');

function route(app) {
  ///route
  app.use('/user', userRouter);
}

module.exports = route;