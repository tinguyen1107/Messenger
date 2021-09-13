const mongoose = require("mongoose");
const { URI_MONGODB } = process.env;

exports.connect = () => {
  mongoose.connect(
    URI_MONGODB,
    {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
      useFindAndModify: false,
    },
    (err) => {
      if (err) {
        console.error(`Fail to connect database ${err}`);
        process.exit(1);
      } else console.log("Connect to database successfully");
    }
  );
};
