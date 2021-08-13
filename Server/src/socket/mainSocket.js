const User = require("../app/models/User")
const Message = require("../app/models/Message")
const Conservation = require("../app/models/Conservation")
const ConservationController = require("../app/controllers/ConservationController")

/*
client : on/off
send message _ realtime message 
*/
module.exports =  function(io) {
    console.log("Socket start");

    io.on("connection", (socket) => {
        socket.user = new User({
            _id: socket.handshake.auth._id,
            email: socket.handshake.auth.email,
            fullname: socket.handshake.auth.fullname,
        })
        console.log(`User connection: \n\tName: ${socket.user.fullname} \n\tEmail: ${socket.user.email} \n\tId: ${socket.user._id}`);
        
        socket.join(socket.user._id);

        // var conservations = ConservationController.getAllConservation()
        // socket.emit("conservation") 

        // var listUsers = []
        // User.find({})
        //     .then(users =>{
        //         users.forEach (element => {
        //             listUsers.push([element._id, element.fullname, element.email]);
        //         });
        //         socket.emit("list_users_in_database", listUsers);               
        //      })
        //     .catch()        
        
        // socket.broadcast.emit("user_connected", {
        //     _id: socket.user._id,
        //     fullname: socket.user.fullname,
        //     email: socket.user.email,
        //     // connected: true,
        // });

        socket.on("create_new_conservation", (ids) => {
            
        })

        socket.on("send_messsage", ({ content, to }) => {
            Conservation.find({users_id: {$all: [socket.user._id, to]}})
                .then(conservation => {
                    if (conservation) {
                        const message = socket.user._id + "_" + content;
                        socket.to(to).to(socket.user._id).emit("send_message", message);
                        Message.findOneAndUpdate(
                            { address: conservation._id }, 
                            { $push: { messages: message }},
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