const jwt = require("jsonwebtoken");

const config = process.env;

const verifyToken = (req, res, next) => {
  const token =
    req.body.token || req.query.token || req.headers["x-access-token"];

  if (!token) {
    return next();
  }
  try {
    const decoded = jwt.verify(token, config.TOKEN_KEY);
    return res.status(200).send(decoded);
  } catch (err) {
    return res.status(402).send("Invalid Token");
  }
};

module.exports = verifyToken;
