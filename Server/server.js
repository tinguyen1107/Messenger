var express = require('express');
var app = express();
app.use(express.static("public"));
app.set("views", "./views");

// Socket
var server = require('http').server(app);
var io = require("socket.io")(server);
server.listen(7000);

// Mongoose
const mongoose = require("mongoose");
mongoose.connect(
    "mongodb+srv://user:X5yRzQ1OwK2zu8Rf@cluster0.2jlrt.mongodb.net/user?retryWrites=true&w=majority",
    {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    }, 
    function(err) {
        if (err) {
            console.error(err);
        } else {
            console.log("Connect to database successfully");
        }
    }
)

