const  mongoose  = require("mongoose");
const messageSchema = new mongoose.Schema({
    address: String,
    messages: [String], 
});
/*
we can encode the message like: 0_hello
in that: 
    0 show who send this message (0, 1);
    _ for split 
    hello is the message
*/
module.exports  =  mongoose.model("Message", messageSchema);