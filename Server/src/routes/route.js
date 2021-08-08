const User = require("../app/models/User");
const Message = require("../app/models/Message")
const UserController = require("../app/controllers/UserController");

function route(app) {
  ///route
  // app.get('/', function(req, res) {
    // User.find({})
    //   .then (user => {
    //     console.log("user: " + user);
    //   })
    // ;
  // });

  app.post('/', function(req, res) {
    const message = new Message({
      content: req.body.content,
      from: req.body.from,
      to: req.body.to,
      time: Date.now()
    })
    
    message.save(function(error) {
        if (error) {
            console.log(error);
        }
    })
    res.json(message)
  })

  app.post("/login", UserController.login);
  app.post("/register", UserController.register);
}

module.exports = route;