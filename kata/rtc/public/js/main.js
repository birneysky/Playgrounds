'use strict'

var localVideo = document.querySelector('video#localVideo')
var remoteVideo = document.querySelector('video#remoteVideo')

var startButton = document.querySelector('button#start')
var callButton = document.querySelector('button#call')
var hangupButton = document.querySelector('button#hangup')

var localStream;
var pc1;
var pc2;

function getMediaStream(stream) {
    localVideo.srcObject = stream
    localStream = stream;
}

function getRemoteStream(e) {
    remoteVideo.srcObject = e.streams[0]
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
                                .then(getMediaStream)
                                .catch(handleError)
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

function call() {
    console.log('call')
    pc1 = new RTCPeerConnection()
    pc2 = new RTCPeerConnection()
    pc1.onicecandidate = (e) => {
        pc2.addIceCandidate(e.candidate)
    }
    pc2.onicecandidate = (e) => {
        pc1.addIceCandidate(e.candidate)
    }

    pc2.ontrack = getRemoteStream
    
    localStream.getTracks().forEach((track) => {
        pc1.addTrack(track, localStream);
    });

    var offerOptions = {
        offerToReceiveAudio:0,
        offerToReceiveVideo:1
    }
    pc1.createOffer(offerOptions)
        .then(getOffer)
        .catch(handleOfferError)
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