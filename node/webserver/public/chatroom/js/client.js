'use strict'

var userName = document.querySelector('input#username')
var inputRoom = document.querySelector('input#room')
var buttonConnect = document.querySelector('button#connect')
var outputArea  = document.querySelector('textarea#output')
var inputArea  = document.querySelector('textarea#input')
var buttonSend = document.querySelector('button#send')

var socket
var room

buttonConnect.onclick = () => {
    /// connect
    socket = io.connect() 
    /// recieve message
    socket.on('joined', (room, id) => {
        buttonConnect.disabled = true
        inputArea.disabled = false
        buttonSend.disabled = false
    })

    socket.on('leave', (room, id) => {
        buttonConnect.disabled = false 
        inputArea.disabled = true 
        buttonSend.disabled = true 
    })

    socket.on('message', (room, id, data) => {
        outputArea.value = outputArea.value + data + '\r'
    })
  
    /// send message
    room = inputRoom.value
    socket.emit('join', room)
}

buttonSend.onclick = () => {
  var data = inputArea.value
  data = userName.value + ':' + data
  socket.emit('message', room, data)
  inputArea.value = ''
}
