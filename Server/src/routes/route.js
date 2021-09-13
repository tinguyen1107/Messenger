const User = require("../app/models/User");
const Message = require("../app/models/Message");
const UserController = require("../app/controllers/UserController");
const ConservationController = require("../app/controllers/ConservationController");
const MessageController = require("../app/controllers/MessageController");

const uploadAvatar = require("../middleware/upload");
const verifyToken = require("../middleware/verifyToken");

const express = require("express");
const router = express.Router();

router.get("/", function (req, res) {
  res.json({
    hello: "world",
  });
});
router.post("/login", verifyToken, UserController.login);
router.post("/register", UserController.register);

router.get("/get_all_users", UserController.getAllUsers);

// app.post("/conservation/create_new_conservation", ConservationController.createNewConservation);
router.post(
  "/conservation/get_all_friends",
  ConservationController.getListConservations
);
router.post(
  "/conservation/get_messages",
  ConservationController.getPreviousMessages
);

router.post(
  "/user/info/edit",
  uploadAvatar.single("avatar"),
  UserController.editInfo
);

module.exports = router;
