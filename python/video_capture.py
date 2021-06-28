import numpy as np
import cv2 as cv

cv.namedWindow('Video')
video_capture = cv.VideoCapture(0)

success, frame = video_capture.read()
while success and not cv.waithKey(1) == 27:
    
    cv.imshow('gray', frame)
    #success, frame = video_capture.read()

video_capture.release()
#cv.destoryWindow('Video')

