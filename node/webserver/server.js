'use strict'

const http = require('http')
const https = require('https')
const fs = require('fs')
const express = require('express')
const serverIndex = require('serve-index')

var app = express()
app.use(serverIndex('./public'))
app.use(express.static('./public'))

var http_server = http.createServer(app)
http_server.listen(80, '0.0.0.0')


const options = {
    key : fs.readFileSync('./leaf_cert.key'),
    cert : fs.readFileSync('./leaf_cert.pem')
}

var https_server = https.createServer(options,app)
https_server.listen(443,'0.0.0.0')
