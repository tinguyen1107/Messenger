const User = require("../models/User");
const httpSupport = require("../../util/HttpSupport");
const fs = require("fs");
var path = require("path");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

class UserController {
  // [POST] /login
  async login(req, res, next) {
    try {
      const { email, password } = req.body;
      console.log(req.body);
      if (!email || !password) {
        return res.status(400).send("All input is required");
      }
      const user = await User.findOne({ email: email });

      if (user && (await bcrypt.compare(password, user.password))) {
        const token = jwt.sign(
          { user_id: user._id, email },
          process.env.TOKEN_KEY,
          {
            expiresIn: "2h",
          }
        );

        user.token = token;

        return res.status(200).json(user);
      }
      return res.status(400).send("Invalid Credentials");
    } catch (err) {
      console.log(err);
    }
  }

  // [POST] /user/register
  async register(req, res, next) {
    try {
      const { email, password, fullname } = req.body;

      if (!email || !password || !fullname) {
        res.status(400).send("All input us required");
      }

      const oldUser = await User.findOne({ email });

      if (oldUser) {
        return res.status(409).send("Email already exist.");
      }

      const encryptedPassword = await bcrypt.hash(password, 10);

      const user = await User.create({
        fullname,
        email,
        password: encryptedPassword,
      });

      const token = jwt.sign(
        { user_id: user._id, email },
        process.env.TOKEN_KEY,
        { expiresIn: "2h" }
      );

      user.token = token;

      res.status(201).json(user);
    } catch (err) {
      console.log(err);
    }
  }

  getUserByListId(listId) {
    const newUser = new User.find({ _id: listId[0] })
      .then((users) => {
        console.log(users);
        return users;
      })
      .catch();
  }

  // [GET] /get_all_users
  getAllUsers(req, res, next) {
    User.find({})
      .then((users) => {
        console.log(users);
        if (users != null) {
          httpSupport.resultResJson(res, 0, users);
        } else {
          httpSupport.resultResJson(res, 1, "There no users");
        }
      })
      .catch((error) => {
        httpSupport.resultResJson(res, 1, "error");
      });
  }

  editInfo(req, res, next) {
    User.findOneAndUpdate(
      { _id: req.body._id },
      { avatar: req.file.filename, fullname: req.body.fullname },
      { new: true },
      function (error, success) {
        if (error) {
          console.log(`update failed. Error: ${error}`);
          httpSupport.resultResJson(res, 1, error);
        } else {
          console.log(`Update success`);
          console.log(success);
          httpSupport.resultResJson(res, 0, req.file.filename);
        }
      }
    );
  }
}

module.exports = new UserController();
