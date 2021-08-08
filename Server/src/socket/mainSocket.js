module.exports =  function(io) {
    console.log("Socket start");
    io.on("connection", (socket) => {
        console.log("user connection");
    })
}