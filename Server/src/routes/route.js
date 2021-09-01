const User = require("../app/models/User");
const Message = require("../app/models/Message")
const UserController = require("../app/controllers/UserController");
const ConservationController = require("../app/controllers/ConservationController");
const MessageController = require("../app/controllers/MessageController")

const multer = require('multer')

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, './uploads');
    },
    filename: function(req, file, cb) {
        cb(null, new Date().toISOString() + file.originalname);
    }
})

const upload = multer({storage: storage})

function route(app) {
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

    app.post("/user/info/edit", upload.single('avatar'), UserController.editInfo)
}

module.exports = route;
