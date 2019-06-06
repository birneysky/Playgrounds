'use strict'

const http = require('http')
const https = require('https')
const fs = require('fs')
const express = require('express')
const serverIndex = require('serve-index')
const socketIO = require('socket.io')
const log4js = require('log4js')

log4js.configure({
    appenders: {
      file: {
        type: 'file',
        filename: 'app.log',
        layout: {
            type: 'pattern',
            pattern: '%r %p - %m',
        }
      }
    },
    categories: {
        default: {
            appenders: ['file'],
            level: 'debug'
        }
    }
})

var logger = log4js.getLogger()
var app = express()
app.use(serverIndex('./public'))
app.use(express.static('./public'))

var http_server = http.createServer(app)
http_server.listen(8080, '0.0.0.0')


const options = {
    key : fs.readFileSync('./leaf_cert.key'),
    cert : fs.readFileSync('./leaf_cert.pem')
}

var https_server = https.createServer(options,app)
var io = socketIO.listen(https_server)
https_server.listen(443,'0.0.0.0')

// 在这个站点下的所有的连接回调
io.sockets.on('connection',(socket) => {
    socket.on('join',(room) => {
      socket.join(room)
      var myRoom = io.sockets.adapter.rooms[room]
      var userCount = Object.keys(myRoom.sockets).length
      logger.log('the number of user in room is: ' + userCount)
      /// 向当前用户回复消息
      /// socket.emit("joined", room, socket.id)
      /// 向房间中除当前加入用户之外的所有用户回复消息
      /// socket.to(room).emit("joined", room, socket.id)
      /// 向房间中所有用户(包括当前用户)回复消息
      /// io.in(room).emit("joined", room, socket.id)
      /// 向站点中所有人(除当前用户)回复消息
      /// socket.broadcast.emit('joined', room, socket.id)  
    })

    
    socket.on('leave',(room) => {
      var myRoom = io.sockets.adapter.rooms[room]
      var userCount = Object.keys(myRoom.sockets).length

      logger.log('the number of user in room is: ' + userCount -1)
      socket.leave(room)
      /// 向当前用户回复消息
      /// socket.emit("joined", room, socket.id)
      /// 向房间中除当前加入用户之外的所有用户回复消息
      /// socket.to(room).emit("joined", room, socket.id)
      /// 向房间中所有用户(包括当前用户)回复消息
      /// io.in(room).emit("joined", room, socket.id)
      /// 向站点中所有人(除当前用户)回复消息
      /// socket.broadcast.emit('joined', room, socket.id)  
    })
})
