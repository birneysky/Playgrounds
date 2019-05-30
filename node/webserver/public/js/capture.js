'use strict'

var videoPlayer = document.querySelector('video#player')
//var audioPlayer = document.querySelector('audio#audioplayer')
var filterSelect = document.querySelector('select#filter')

var snapshot = document.querySelector('button#snapshot')
var picture = document.querySelector('canvas#picture')
picture.width = 320
picture.height = 240

var divConstraints = document.querySelector('div#constraints')

function start() {
    if (!navigator.mediaDevices ||
        !navigator.mediaDevices.enumerateDevices) {
        console.log('enumerateDevices is not supported!')
        return
    } else {
        var constraints =  {
            video : {
                width:  640,
                height: 480,
                frameRate: 30,
                facingMode: 'enviroment' /* 移动端有效,user 表示后置摄像头，environment表示前置摄像头*/
            },
            audio : {
                /// echoCancellation 回声消除 true/false
                /// autoGainControl  自动增益 true/false
                /// noiseSuppression 噪声抑制 true/false
                /// latency  延迟大小 
                /// channelCount 单声道、双声道 
                /// deviceID 有多个设备可以进行设备切换
                /// groupID 
                /// 
                echoCancellation: true,
                noiseSuppression: true,
            }
    }

    navigator.mediaDevices.getUserMedia(constraints)
             .then(gotMediaStream)
             .catch(handleError)
 }

}

function gotMediaStream(stream) {
    //audioplayer.strobject = stream
    var videoTrack = stream.getVideoTracks()[0]
    var videoConstraints = videoTrack.getSettings()
    divConstraints.textContent = JSON.stringify(videoConstraints, null, 2)
    videoPlayer.srcObject = stream
}

function handleError(err) {
    console.log('getUserMedia error:',error)
}

start()
filterSelect.onchange = function() {
    videoPlayer.className = filterSelect.value
}

snapshot.onclick = function() {
    picture.className = filterSelect.value
    picture.getContext('2d').drawImage(videoPlayer,0,0,picture.width,picture.height)
}
