const  mongoose  = require("mongoose");
const messageSchema = new mongoose.Schema({
    content: String,
    from: String,
    to: String,
    time: Date
});

module.exports  =  mongoose.model("Message", messageSchema);