const mongoose = require("mongoose");
const userSchema = new mongoose.Schema({
  email: { type: String, unique: true },
  password: { type: String },
  fullname: { type: String },
  avatar: { type: String, default: "default" },
  token: { type: String },
});

module.exports = mongoose.model("User", userSchema);
