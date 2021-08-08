const User = require("../models/User");

function resultResJson (res, result, details) {
	res.json({
		result,
		details,
	})
}

class UserController {
	// [POST] /login
	login (req, res, next) {
		console.log(req.params)
		console.log(req.body)
		if (!req.body.email || !req.body.password) {
			resultResJson(res, 1, {error: "There is not enough parameters"});
		} else {
			User.findOne({ email: req.body.email })
				.then(user => {
					if (!user) {
						resultResJson(res, 1, {error: "There are no email like this"})
					} else {
						if (user.password == req.body.password) {
							resultResJson(res, 0, user);
							console.log(user)
						} else {
							resultResJson(res, 1, {error: "Wrong password"});
						}  
					}
				}) 
				.catch(next)
		}
	}

	// [POST] /user/register
	register (req, res, next) {
		if (!req.body.email || !req.body.password || !req.body.fullname) {
			resultResJson(res, 1, {error: "There is not enough parameters"});
		} else {
			User.findOne({ email: req.body.email})
				.then(user => {
					if (user) {
						resultResJson(res, 1, {error: "This email has already been"});
					} else {
						const newUser = new User({
							email: req.body.email,
							password: req.body.password,
							fullname: req.body.fullname,
						})
						newUser.save(function(error) {
							if (error) {
								resultResJson(res, 2, "Mongoose save error" + error);
							} else { 
								resultResJson(res, 0, user);
							}
						})
					}
				})
				.catch(next)
		}
	}
}

module.exports = new UserController();