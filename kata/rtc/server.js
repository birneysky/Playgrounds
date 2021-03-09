'use strict'

const https = require('https')
const fs = require('fs')
const express = require('express')

const options = {
	key: fs.readFileSync ('server.key'),
	cert: fs.readFileSync ('server.cert')
};

const PORT = 443;
const base = 'public';

var app = express()
app.use(express.static('./public'))

https.createServer(options, app).listen(PORT, function () {
    console.log('Https server listening on port ' + PORT);
});

