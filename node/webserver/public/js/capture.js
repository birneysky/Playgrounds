'use strict'

var videoPlayer = document.querySelector('video#player')

if (!navigator.mediaDevices ||
    !navigator.mediaDevices.enumerateDevices) {
    console.log('enumerateDevices is not supported!')
 } else {
    var constraints =  {
        video : true,
        audio : true
    }

    navigator.mediaDevices.getUserMedia(constraints)
             .then(gotMediaStream)
             .catch(handleError)
 }



function gotMediaStream(stream) {
    videoPlayer.srcObject = stream
}

function handleError(err) {
    console.log('getUserMedia error:',error)
}
