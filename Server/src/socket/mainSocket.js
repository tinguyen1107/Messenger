const User = require("../app/models/User")
const Message = require("../app/models/Message")
const Conservation = require("../app/models/Conservation")
const ConservationController = require("../app/controllers/ConservationController")

module.exports =  function(io) {
    console.log("Socket start");

    io.on("connection", (socket) => {
        socket.user = {
            _id: socket.handshake.auth._id,
            email: socket.handshake.auth.email,
            fullname: socket.handshake.auth.fullname,
            password: "",
        }
        socket.state = socket.handshake.auth.password /// login or register
        console.log(`User connection socket: ${socket.user.fullname}`);
        
        socket.join(socket.user._id);

        if (socket.state == "login") console.log("Login")
        else console.log("Register")

        socket.on("create_conservation_submit", (newFriend_id) => {
            console.log(`Create new conservation ${socket.user._id} with ${newFriend_id}`)

            var conservation = new Conservation ({
                address: "",
                users_id: [socket.user._id, newFriend_id],
            })
            conservation.address = conservation._id.toString();
            
            socket.on("respone_ask_create_conservation", (data) => {
                if (data) {
                    conservation.save(function(error) {
                        if (!error) {
                            var message = new Message({
                                address: conservation._id.toString(),
                                messages: [],
                            })

                            message.save(function(error) {
                                if (!error) {
                                    console.log("CREATE__conservation__SUCCESSFULLY")

                                    socket.emit("respone_create_conservation", socket.user)
                                }
                            })
                        }
                    })
                }
            })

            socket.to(newFriend_id).emit("someone_create_consevation_receive", socket.user)



            conservation.save(function(error) { 
                if (!error) {
                    var message = new Message({
                        address: conservation._id.toString(),
                        messages: [], 
                    })
                    message.save(function(error) {
                        if(!error) {
                            console.log("CREATE__conservation__SUCCESSFULLY")

                            socket.to(newFriend_id).emit("someone_create_consevation_receive", socket.user)
                            socket.emit("respone_create_conservation", socket.user)
                        }
                    })
                }
            })
        })

        socket.on("send_messsage", (data) => {
            console.log(`Message: ${data}`) /// "toId_messages"
            const arr = data.split("_")
            console.log(arr)
            Conservation.find({users_id: {$all: [socket.user._id, arr[0]]}})
                .then(conservation => {
                    // console.log(`Conservation: ${conservation}`)
                    if (conservation) {
                        const message = socket.user._id + "_" + arr[1];
                        socket.to(arr[0]).emit("receive_message", message);
                        io.to(socket.user._id).emit("receive_message", message);
                        Message.findOneAndUpdate(
                            { address: conservation[0].address },
                            { $push: { messages: message }},
                            { new: true },
                            function (error, success) {
                                if (error) {
                                    console.log(error);
                                } else {
                                    console.log(success);
                                }
                            });
                    }
                })
                .catch()
        });
    
        socket.on("disconnect", async () => {
            // const matchingSockets = await io.in(socket.userID).allSockets();
            // const isDisconnected = matchingSockets.size === 0;
            // if (isDisconnected) {
            //     // notify other users
            //     socket.broadcast.emit("user disconnected", socket.userID);
            //     // update the connection status of the session
            //     sessionStore.saveSession(socket.sessionID, {
            //         userID: socket.userID,
            //         username: socket.username,
            //         connected: false,
            //     });
            // }
            console.log(`${socket.user.fullname} disconnected`)
        });
    })
}
