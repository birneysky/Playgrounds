//
//  SceneryCapturer.swift
//  Camera
//
//  Created by birneysky on 2019/5/8.
//  Copyright © 2019 Grocery. All rights reserved.
//

import AVFoundation

protocol SceneryCapturerOutputDelegate: class {
    func didOutputSampleBuffer(_ buffer: CMSampleBuffer)
}

final class SceneryCapturer : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    // MARK: - Properties
    public weak var delegate: SceneryCapturerOutputDelegate?
    fileprivate var videoConnection: AVCaptureConnection!
    fileprivate lazy var videoDevice: AVCaptureDevice = {
        guard let device = AVCaptureDevice.default(for: .video) else {
            fatalError("video device is nil")
        }
        return device
    }()
    
    fileprivate lazy var sessionQueue: DispatchQueue = {
        let queue = DispatchQueue(label: "com.camera.SceneryCapturer.session")
        return queue
    }()
    
    fileprivate lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }()
    
    
    // MARK: - Init
    public override init() {
        super.init()
        setupCaptureSession()
    }
    
    public func startRunning() {
        if !self.captureSession.isRunning {
            weak var weakSelf = self;
            self.sessionQueue.async {
                weakSelf?.captureSession.startRunning()
            }
        }
    }
    
    public func stopRunning() {
        if self.captureSession.isRunning {
            weak var weakSelf = self;
            self.sessionQueue.async {
                weakSelf?.captureSession.stopRunning()
            }
        }
    }
    
    public func focus(at point:CGPoint) {
        
    }
    
    // MARK: - Helper
    fileprivate func setupCaptureSession() {
        NotificationCenter.default.addObserver(self, selector: #selector(sessionWasInterrupted(_:)), name: .AVCaptureSessionWasInterrupted, object: nil)
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: self.videoDevice)
            if self.captureSession.canAddInput(videoDeviceInput) {
                self.captureSession.addInput(videoDeviceInput)
            }
        } catch let error as NSError {
            print(error)
        }
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
        videoDataOutput.alwaysDiscardsLateVideoFrames = false
        
        if self.captureSession.canAddOutput(videoDataOutput) {
            self.captureSession.addOutput(videoDataOutput)
        }
        self.videoConnection = videoDataOutput.connection(with: .video)
        
        self.captureSession.sessionPreset = .cif352x288
        
        
        do {
            let duration = CMTimeMake(value: 1, timescale: 20)
            try self.videoDevice.lockForConfiguration()
            self.videoDevice.activeVideoMaxFrameDuration = duration
            self.videoDevice.activeVideoMinFrameDuration = duration
            self.videoDevice.unlockForConfiguration()
        } catch let error as NSError {
            print(error)
        }
        
        self.videoConnection?.videoOrientation = .portrait
    }
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        self.delegate?.didOutputSampleBuffer(sampleBuffer)
    }
    // MARK: - Notification selector
    @objc func sessionWasInterrupted(_ notification: Notification) {
        print("Capture session was interrupted with reason: \(notification)")
    }
}
