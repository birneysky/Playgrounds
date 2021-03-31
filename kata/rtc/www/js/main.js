'use strict'

var localVideo1 = document.querySelector('video#localVideo1')
var remoteVideo1 = document.querySelector('video#remoteVideo1')

var localVideo2 = document.querySelector('video#localVideo2')
var remoteVideo2 = document.querySelector('video#remoteVideo2')

var startButton = document.querySelector('button#start')
var callButton = document.querySelector('button#call')
var hangupButton = document.querySelector('button#hangup')

var canvas1 = fx.canvas()
var canvas2 = fx.canvas()

var localStream;
var pc1;
var pc2;
var canvasVideoStream1
var canvasVideoStream2 


function getRemoteStream(e) {
    remoteVideo1.srcObject = e.streams[0]
}

function handleError(err) {
    console.error(err)
}

function start() {
    console.log('start')
    if (!navigator.mediaDevices || 
        !navigator.mediaDevices.getUserMedia) {
        console.error('the getuserMedia is not support')
    } else {
        var constraints = {
            video: true,
            audio: false
        }
        navigator.mediaDevices.getUserMedia(constraints)
                                .then((stream) => {
                                    localVideo1.srcObject = stream
                                    localVideo2.srcObject = stream
                                    localStream = stream
                                })
                                .catch((err) => {
                                    console.error(err)
                                })
    }
}

function getOffer(desc) {
    pc1.setLocalDescription(desc)

    pc2.setRemoteDescription(desc)

    pc2.createAnswer()
        .then(getAnswer)
        .catch(handleAnswerError)
}

function getAnswer(desc) {
    pc2.setLocalDescription(desc);

    pc1.setRemoteDescription(desc);
}

function handleAnswerError(err) {
    console.error("failed to create answer",err)
}

function handleOfferError(err) {
    console.error("failed to create offer",err)
}

function startFilter1() {
    if (!canvasVideoStream1) {
        canvasVideoStream1 = canvas1.captureStream()
    }
    videoToCanvas1()
}

function videoToCanvas1()
{
    var texture = canvas1.texture(localVideo1);
    canvas1.draw(texture).hexagonalPixelate(320, 239.5, 20).update()
    window.requestAnimationFrame(videoToCanvas1);
}

function startFilter2() {
    if (!canvasVideoStream2) {
        canvasVideoStream2 = canvas2.captureStream()
    }
    videoToCanvas2()
}

function videoToCanvas2()
{
    var texture = canvas2.texture(localVideo2);
    canvas2.draw(texture).colorHalftone(320, 239.5, 0.25, 4).update()    
    window.requestAnimationFrame(videoToCanvas2);
}

function call() {
    console.log('call')
    pc1 = new RTCPeerConnection()
    pc2 = new RTCPeerConnection()
    pc1.onicecandidate = (e) => {
        console.log("pc1 candidate:", e.candidate);
        pc2.addIceCandidate(e.candidate)
    }
    pc2.onicecandidate = (e) => {
        console.log("pc2 candidate:", e.candidate);
        pc1.addIceCandidate(e.candidate)
    }

    pc1.ontrack = (e) => {
        console.log("pc2 on track")
        remoteVideo1.srcObject = e.streams[0]
    }

    pc2.ontrack = (e) => {
        console.log("pc2 on track")
        remoteVideo2.srcObject = e.streams[0]
    }
    
    startFilter1()
    pc1.addTrack(canvasVideoStream1.getVideoTracks()[0], canvasVideoStream1);

    startFilter2()
    pc2.addTrack(canvasVideoStream2.getVideoTracks()[0], canvasVideoStream2);
    // localStream.getTracks().forEach((track) => {
    //     pc1.addTrack(track, localStream)
    // });

    var offerOptions = {
        offerToReceiveAudio:0,
        offerToReceiveVideo:1
    }
    pc1.createOffer(offerOptions).then((desc) => {
            console.log('offer:',desc.sdp)
            pc1.setLocalDescription(desc)
            pc2.setRemoteDescription(desc)
            pc2.createAnswer().then((desc) => {
                console.log('answer:',desc.sdp)
                pc2.setLocalDescription(desc)
                pc1.setRemoteDescription(desc)
            }).catch((err) => {
                console.error("failed to create answer",err)
            })
        }).catch((err) => {
            console.error("failed to create offer",err)
        })
}

function hangup() {
    console.log('hangup')
    pc1.close()
    pc2.close()
    pc1 = null
    pc2 = null
}

startButton.onclick = start
callButton.onclick = call
hangupButton.onclick = hangup