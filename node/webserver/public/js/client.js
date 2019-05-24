'use strict'

if (!navigator.mediaDevices ||
    !navigator.mediaDevices.enumerateDevices) {
    console.log('enumerateDevices is not supported!')   
 } else {
    navigator.mediaDevices.enumerateDevices()
             .then(gotDevices)
             .catch(handleError)
 }


 function gotDevices(deviceInfo) {
    console.log(deviceInfo) 
 }

 function handleError(error) {
 
 
 }
