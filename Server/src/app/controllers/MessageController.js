const Message = require("../models/Message")

class MessageController {
    addNewMessage (message) {
        Mesage.find({ address: addressMessage })
            .then(message => {
                return message.messages
            })
            .catch ()
    }

    createNewMesage (address) {
        const message = newMessage({
            address,
            messages: [],
        })
        message.save(function(error) {
            if (error) {
                return 1 // save falses
            } else {
                return 0 // save success
            }
        })
    }

    getMessage(addressMessage) {
        Message.find({ address: addressMessage })
            .then(message => {
                return message.messages
            })
            .catch ()
    }
}

module.exports = new MessageController();