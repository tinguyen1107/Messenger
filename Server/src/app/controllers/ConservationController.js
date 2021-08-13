const Conservation = require('../models/Conservation')
const httpSupport = require("../../util/HttpSupport");
const UserController = require("./UserController")
const MessageController = require("./MessageController")

const User = require("../models/User") 
const Message = require("../models/Message")


class ConservationController {
    // // [POST] /conservation/create_new_conservation
    // createNewConservation(req, res, next) {
    //     var ids = req.body.ids

    //     const newConservation = new Conservation({
    //         users_id: ids,
    //     })

    //     newConservation.save(function(err) {
    //         if (err) {
    //             httpSupport.resultResJson(res, 1, "Create failed");
    //         } else {
    //             httpSupport.resultResJson(res, 0, "Create successfully");
    //         }
    //     })
    // }

    // findExactlyConservation (userID1, userID2) {
    //     Conservation.find({ user_id:  { $all: [userID1, userID2] } })
    //         .then (conservation => {
    //             return conservation;
    //         })
    //         .catch()
    // }

    // getAllConservation(user) {
    //     Conservation.find({ users_id: user._id })
    //         .then (conservations => {
    //             if (conservation == null) {
    //                 // there are no any conservations for user
    //             } else {
    //                 // there are conservations for user
    //                 // return conservations
    //             }
    //         })
    //         .catch()
    // }

    //// [POST] /conservation/get_all_friends
    getListConservations (req, res, next) {
        var id = req.body.id
        console.log (`User ${req.body.id} ask for List Conservation`)
        Conservation.find({ users_id: id })
            .then (conservations => {
                if (conservations == null) {
                    httpSupport.resultResJson(res, 1, "There no any conservations");
                } else {
                    const listId = conservations.map(x => {
                        if (x.users_id[0] == id) return x.users_id[1] 
                        else return x.user_id[0]
                    })
                    console.log (`User ${listId}`)
                    User.find({ _id: {$in: listId} })
                        .then (users => {
                            console.log (users)
                            httpSupport.resultResJson(res, 0, users);
                        })
                        .catch(next)
                    
                }
            })
            .catch(next)
    }

    // [POST] /conservation/get_messages
    getPreviousMessages (req, res, next) {
        // get address
        var ids = req.body.ids;
        console.log(ids)
        Conservation.find({ users_id: {$all: ids} }) 
            .then( conservation => {
                console.log (conservation)
                if (conservation) {
                    var listAddress = conservation.map(x => {
                        return x.address;
                    })
                    console.log (listAddress)
                    Message.find({ address: {$in: listAddress} })
                        .then(message => {
                            console.log (message)
                            
                            httpSupport.resultResJson(res, 0, message[0].messages);
                        })
                        .catch ()
                } else {
                    httpSupport.resultResJson(res, 1, "can't find this address");
                }
            })
            .catch ()
    }
}

module.exports = new ConservationController();