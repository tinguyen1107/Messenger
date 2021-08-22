const express = require('express');
var app = express();
const path = require('path');

// app.use(express.static("public"));
// app.set("views", path.join(__dirname, 'views'));

app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);

app.set('view engine', 'ejs');

const port = 3000;

app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`);
});

app.get("/", (req, res, next) => {
    res.render('homeView.html')
    // res.send(`${port}`)
})