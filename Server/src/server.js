const express = require('express');
const app = express()
// Note 1+2 -> const app = requiere('express')();

var http = require('http').createServer(app);

// require the socket.io module
var io = require('socket.io')(http);

//database connection
// const  Chat  = require('./app/models/ChatSchema');
// const  connect  = require("./database/dbConnection");

// Our port
const port = 7000;

//wire up the server to listen to our port
http.listen(port, function (data) {
    console.log (`LISTEN TO PORT ${port}`);
});

////
app.get('/', function (req, res) {
    console.log('hello connected')
});

app.post('/login', function (req, res, next) {

});

app.post('/register', function (req, res, next) {

});

const crypto = require("crypto");
const randomId = () => crypto.randomBytes(20).toString("hex");

// io.use((socket, next) => {
//     const sessionID = socket.handshake.auth.sessionID;
//     if (sessionID) {
//       const session = sessionStore.findSession(sessionID);
//       if (session) {
//         socket.sessionID = sessionID;
//         socket.userID = session.userID;
//         socket.username = session.username;
//         return next();
//       }
//     }
//     const username = socket.handshake.auth.username;
//     // console.log(`name: ${socket.handshake.auth.username}`)
//     if (!username) {
//       return next(new Error("invalid username"));
//     }
//     socket.sessionID = randomId();
//     socket.userID = randomId();
//     socket.username = username;

//     console.log(`name: ${socket.username}`)
//     return next();
// });

////
io.on('connection', (socket) => {
    console.log(`user connected with id: ${socket.id}`);
    // socket.handshake.auth.sessionID
    console.log(`info: ${JSON.stringify(socket.handshake.auth)}`)
    console.log(`auth: ${socket.handshake.auth.auth}`)

    

    socket.sessionID = randomId();
    socket.userID = randomId();
    socket.username = socket.handshake.auth.username;

    console.log(`name: ${socket.username}`)
});
//To listen to messages
// socket.on("connection", (socket)=>{
//     console.log(`user connected with id: ${socket.id}`);
    
//     socket.on("disconnect", ()=>{
//         console.log("Disconnected")
//     });

//     socket.on("chat message", function(msg){
//         console.log('message: '  +  msg);
//         //broadcast message to everyone in port:7000 except yourself.
//         socket.broadcast.emit("received", { message: msg  });

//         connect.then(db  =>  {
//             console.log("connected correctly to the server");
        
//             let  chatMessage  =  new Chat({ message: msg, sender: "Anonymous"});
//             chatMessage.save();
//         });

//         socket.on("typing", data => { 

//             socket.broadcast.emit("notifyTyping", { user: data.user, message: data.message }); }); 
        
//         //when soemone stops typing
        
//         socket.on("stopTyping", () => { socket.broadcast.emit("notifyStopTyping"); });
//     });
// });
