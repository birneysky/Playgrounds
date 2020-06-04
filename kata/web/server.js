'use strict'

const http = require('http')
const https = require('https')
const fs = require('fs')
const express = require('express')

var app = express()
app.use(express.static('./public'))

var http_server = http.createServer(app)
http_server.listen(8080, '0.0.0.0')

