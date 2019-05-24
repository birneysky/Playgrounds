'use strict'

const http = require('http')

var app = http.createServer(function(req,res) {
    res.writeHead(200,{'content-type':'text/plain'})
    res.end('Hello world\n')
}).listen(8080,'0.0.0.0')


const https = require('https')
const fs = require('fs')

const options = {
    key : fs.readFileSync('./leaf_cert.key'),
    cert : fs.readFileSync('./leaf_cert.pem')
}

var apps = https.createServer(options, function(req,res) { 
    res.writeHead(200,{'Content-Type':'text/plain'})
    res.end('https://Hello world\n')
}).listen(443, '0.0.0.0')
