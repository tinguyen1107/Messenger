const  mongoose  = require("mongoose");
const conservationSchema = new mongoose.Schema({
    address: String,
    users_id: [String],
});

module.exports  =  mongoose.model("Conservation", conservationSchema);