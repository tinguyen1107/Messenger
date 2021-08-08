const User = require("../app/models/User");
const UserController = require("../app/controllers/UserController");

function route(app) {
  ///route
  app.get('/', function(req, res) {
    var user = new User({
      email: "nttin@gmail.com", 
      password: "123456",
      fullname: "Nguyen Trong Tin",
    })

    res.json(user);
  });

  app.post("/login", UserController.login);
  app.post("/register", UserController.register);
}

module.exports = route;