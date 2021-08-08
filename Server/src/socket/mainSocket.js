const User = require("../app/models/User")
const Message = require("../app/models/Message")

module.exports =  function(io) {
    console.log("Socket start");

    io.on("connection", (socket) => {
        socket.user = new User({
            _id: socket.handshake.auth._id,
            email: socket.handshake.auth.email,
            fullname: socket.handshake.auth.fullname,
        })
        console.log(`User connection: \n\tName: ${user.fullname} \n\tEmail: ${user.email} \n\tId: ${user._id}`);
        
        socket.join(socket.user.userID);

        var listUsers = []
        User.find({})
            .then(users =>{
                users.forEach (element => {
                    listUsers.push([element._id, element.fullname, element.email]);
                });
             })
            .catch()
        
        socket.to(socket.user.userID).emit("list_users_in_database", listUsers);
        
        socket.broadcast.emit("user_connected", {
            _id: socket.user._id,
            fullname: socket.user.fullname,
            // connected: true,
        });

        socket.on("send_messsage", ({ content, to }) => {
            const message = new Message({
                content: content,
                from: socket.user._id,
                to: to,
                time: Date.now()
            })
            
            message.save(function(error) {
                if (error) {
                    console.log(error);
                }
            })

            socket.to(to).to(socket.user._id).emit("send_message", {
                content: message.content,
                from: message.from,
                to: message.to,
                time: message.time,
            });
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