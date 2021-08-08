const  mongoose  = require("mongoose");
const userSchema = new mongoose.Schema({
    email: String, 
    password: String,
    fullname: String,
});



// const  Schema  =  mongoose.Schema;
// const  chatSchema  =  new Schema(
//     {
//     message: {
//     type: String
//     },
//     sender: {
//     type: String
//         }
//     },
//         {
//     timestamps: true
// });

// let  Chat  =  mongoose.model("Chat", chatSchema);
module.exports  =  mongoose.model("User", userSchema);