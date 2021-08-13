var express = require('express');
var app = express();
app.use(express.static("public"));
app.set("views", "./views");

// Socket
var server = require('http').Server(app);
var io = require("socket.io")(server);
require ("./socket/mainSocket")(io);

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

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({extend: false}))

require("./routes/route")(app);