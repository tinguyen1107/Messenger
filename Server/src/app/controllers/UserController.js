const User = require("../models/User");
const httpSupport = require("../../util/HttpSupport");

class UserController {
	// [POST] /login
	login (req, res, next) {
		console.log(req.params)
		console.log(req.body)
		if (!req.body.email || !req.body.password) {
			httpSupport.resultResJson(res, 1, {error: "There is not enough parameters"});
		} else {
			User.findOne({ email: req.body.email })
				.then(user => {
					if (!user) {
						httpSupport.resultResJson(res, 1, {error: "There are no email like this"})
					} else {
						if (user.password == req.body.password) {
							httpSupport.resultResJson(res, 0, user);
							console.log(user)
						} else {
							httpSupport.resultResJson(res, 1, {error: "Wrong password"});
						}  
					}
				}) 
				.catch(next)
		}
	}

	// [POST] /user/register
	register (req, res, next) {
		if (!req.body.email || !req.body.password || !req.body.fullname) {
			httpSupport.resultResJson(res, 1, {error: "There is not enough parameters"});
		} else {
			User.findOne({ email: req.body.email})
				.then(user => {
					if (user) {
						httpSupport.resultResJson(res, 1, {error: "This email has already been"});
					} else {
						const newUser = new User({
							email: req.body.email,
							password: req.body.password,
							fullname: req.body.fullname,
						})
						newUser.save(function(error) {
							if (error) {
								httpSupport.resultResJson(res, 2, "Mongoose save error" + error);
							} else { 
								httpSupport.resultResJson(res, 0, newUser);
							}
						})
					}
				})
				.catch(next)
		}
	}

	getUserByListId(listId) {
		User.find({ _id: listId[0] })
			.then (users => {
				console.log (users)
				return users;
			})
			.catch()
	}

	// [GET] /get_all_users
	getAllUsers (req, res, next) {
		User.find({})
		.then(users => {
			// httpSupport.resultResJson(res, 0, users);
			console.log (users)
			if (users != null) {
				httpSupport.resultResJson(res, 0, users);
			} else {
				httpSupport.resultResJson(res, 1, "There no users");
			}
		})
		.catch(error => {
			httpSupport.resultResJson(res, 0, "error");
		})
	}

}

module.exports = new UserController();