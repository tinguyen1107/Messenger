const User = require("../app/models/User");
const Message = require("../app/models/Message")
const UserController = require("../app/controllers/UserController");
const ConservationController = require("../app/controllers/ConservationController");
const MessageController = require("../app/controllers/MessageController")

function route(app) {
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
app.get('/', function(req, res) {
  res.json({
    "messenger": "?? sao v"
  })
})
  app.post("/login", UserController.login);
  app.post("/register", UserController.register);
  
  app.get("/get_all_users", UserController.getAllUsers);

  // app.post("/conservation/create_new_conservation", ConservationController.createNewConservation);
  app.post("/conservation/get_all_friends", ConservationController.getListConservations);
  app.post("/conservation/get_messages", ConservationController.getPreviousMessages);
}

module.exports = route;