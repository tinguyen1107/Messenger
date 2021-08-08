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

//user
//X5yRzQ1OwK2zu8Rf
//mongodb+srv://user:X5yRzQ1OwK2zu8Rf@cluster0.2jlrt.mongodb.net/user?retryWrites=true&w=majority

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

const { InMemorySessionStore } = require("./sessionStore");
const sessionStore = new InMemorySessionStore();

////
io.on('connection', (socket) => {
    var loginSuccess = false;
    console.log(`user connected with id: ${socket.id}`);

    socket.on("login", ({ content, to }) => {
        const username = content.username;
        const password = content.password;

        const session = sessionStore.login(username, password);
        if (session) {
            socket.sessionID = session.sessionID;
            socket.userID = session.userID;
            socket.username = session.username;
            loginSuccess = true;
        }
    });
    
    socket.on("register", ({ content, to }) => {
        const username = content.username;
        const password = content.password;
        const age = content.age;

        socket.sessionID = randomId();
        socket.userID = randomId();

        sessionStore.saveSession(socket.sessionID, {
            userID: socket.userID,
            username: socket.username,
            connected: true,
        });
    });
    


    const sessionID = socket.handshake.auth.sessionID;

    if (sessionID) {
        const session = sessionStore.findSession(sessionID);
        if (session) {
            socket.sessionID = sessionID;
            socket.userID = session.userID;
            socket.username = session.username;
            return next();
        }
    } else {
        const username = socket.handshake.auth.username;
        socket.sessionID = randomId();
        socket.userID = randomId();
        socket.username = socket.handshake.auth.username;
    }

    // persist session
    sessionStore.saveSession(socket.sessionID, {
        userID: socket.userID,
        username: socket.username,
        connected: true,
    });

    // emit session details
    socket.emit("session", {
        sessionID: socket.sessionID,
        userID: socket.userID,
    });

    // join the "userID" room
    socket.join(socket.userID);

    // fetch existing users
    const users = [];
    sessionStore.findAllSessions().forEach((session) => {
        users.push({
        userID: session.userID,
        username: session.username,
        connected: session.connected,
        });
    });

    socket.emit("users", users);

    console.log(`name: ${socket.username}`)

      // notify existing users
    socket.broadcast.emit("user connected", {
        userID: socket.userID,
        username: socket.username,
        connected: true,
    });

    // forward the private message to the right recipient (and to other tabs of the sender)
    socket.on("private message", ({ content, to }) => {
        socket.to(to).to(socket.userID).emit("private message", {
        content,
        from: socket.userID,
        to,
        });
    });

    socket.on("disconnect", async () => {
        const matchingSockets = await io.in(socket.userID).allSockets();
        const isDisconnected = matchingSockets.size === 0;
        if (isDisconnected) {
          // notify other users
          socket.broadcast.emit("user disconnected", socket.userID);
          // update the connection status of the session
          sessionStore.saveSession(socket.sessionID, {
            userID: socket.userID,
            username: socket.username,
            connected: false,
          });
        }
    });
});
