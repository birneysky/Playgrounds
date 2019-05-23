'use strict'

var http = require('http')

var app = http.createServer(function(req,res){
    res.writeHead(200,{'content-type':'text/plain'});
    res.end('Hello world\n');
}).listen(8080,'0.0.0.0');


var https = require('https')
var fs = require('fs')

var options = {
    key : fs.readFileSync('.key'),
    cert : fs.readFileSync('.pem')
}

var apps = https.createServer(options, function(req,res){ 
    res.writeHead(200,{'Content-Type':'text/plain'});
    res.end('Hello world\n');
}).listen(443, '0.0.0.0');
