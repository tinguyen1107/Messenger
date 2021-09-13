const multer = require("multer");
const { GridFsStorage } = require("multer-gridfs-storage");

const storage = new GridFsStorage({
  url: "mongodb+srv://user:X5yRzQ1OwK2zu8Rf@cluster0.2jlrt.mongodb.net/user?retryWrites=true&w=majority",
  options: {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
  file: (req, file) => {
    console.log(req.body);
    const match = ["image/png", "image/jpeg", "image/jpg"];
    const filename = `${new Date().toISOString()}_${file.originalname}`;

    if (match.indexOf(file.mimetype) === -1) {
      return filename;
    }

    return {
      bucketName: "photos",
      filename: filename,
    };
  },
});

module.exports = multer({ storage });
