var express = require("express");
const cors = require('cors')
const bodyParser = require('body-parser')
var app = express();
const move = require('move-file')
const fs = require('fs')
const path = require('path')
const copyFile = require('fs-copy-file');

const cp = (from, to) => 

    new Promise((resolve, reject) => {
        fs.copyFile(from, to, () => { resolve(); })
    })

app.use(cors())

app.use(bodyParser.json());

app.post('/upload', async (req, res) => {

    //await move('./staged/' + req.body.filename, './public/' + req.body.filehash)
    await cp('./staged/' + req.body.filename, './public/' + req.body.filehash)
    res.status(201).json({ ok: true })
})

app.get('/uploadedFiles', async (req, res) => {
    res.status(200).json({ files: fs.readdirSync('./public') })
})

app.use('/static', express.static(path.join(__dirname, 'public')))

app.listen(3000, () => {
 console.log("Server running on port 3000");
});