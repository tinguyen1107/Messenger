var express = require("express");
var app = express();
app.use(express.static("public"));
app.set("views", "./views");

require("dotenv").config();
const { PORT } = process.env;
// Socket
var server = require("http").Server(app);
var io = require("socket.io")(server);
require("./socket/mainSocket")(io);

const port = PORT;
server.listen(port, () => {
  console.log(`Server running on port: ${port}`);
});

// Mongoose
require("./config/database").connect();

var bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extend: false }));
app.use(bodyParser.json());

var router = require("./routes/route");

//const Grid = require("gridfs-stream");
//let gfs;
//
//
//const conn = mongoose.connection;
//conn.once("open", function () {
//  gfs = Grid(conn.db, mongoose.mongo);
//  gfs.collection("photos");
//});
//
//app.get("/file/:filename", async (req, res) => {
//  try {
//    console.log(req.params.filename);
//
//    const file = await gfs.files.findOne({ filename: req.params.filename });
//    const readStream = gfs.createReadStream(file.filename);
//    readStream.pipe(res);
//    console.log("SUCCESS");
//  } catch (error) {
//    res.send("not found");
//  }
//});

app.use("/", router);
