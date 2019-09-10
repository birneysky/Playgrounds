//
//  SceneryCapturer.swift
//  Camera
//
//  Created by birneysky on 2019/5/8.
//  Copyright © 2019 Grocery. All rights reserved.
//

import Foundation
import AVFoundation

protocol SceneryCapturerOutputDelegate: class {
    func didOutputSampleBuffer(_ buffer: CMSampleBuffer)
    
    func focusDidfinish(at point:CGPoint)
}

final class SceneryCapturer : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK: - Properties
    public weak var delegate: SceneryCapturerOutputDelegate?
    fileprivate var videoConnection: AVCaptureConnection!
    fileprivate var activeVideoInput: AVCaptureDeviceInput!
    fileprivate var activeVideoOutput: AVCaptureVideoDataOutput!
    fileprivate let focusKeyPath = "adjustingFocus"
    
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
    
    fileprivate var cameraCount: Int {
        return AVCaptureDevice.devices(for: .video).count
    }
    
    fileprivate var activeCamera: AVCaptureDevice  {
        return self.activeVideoInput.device
    }
    
    fileprivate var inactiveCamera: AVCaptureDevice? {
        if activeCamera.position == .back {
            return videoDevice(in: .front)
        } else {
            return videoDevice(in: .back)
        }
    }
    
    public var cameraPostion: AVCaptureDevice.Position {
        return self.activeCamera.position
    }
    
    // MARK: - Init
    public override init() {
        super.init()
        setupCaptureSession()
    }
    
    // MARK: - API
    public func startRunning() {
        if !self.captureSession.isRunning {
            weak var weakSelf = self;
            self.sessionQueue.async {
                weakSelf?.captureSession.startRunning()
                weakSelf?.focus(at: .init(x: 0.5, y: 0.5))
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
    
    public func swithCamera() -> Bool {
        guard self.canSwitchCamera() else {
            NSLog("this device has only one camera");
            return false;
        }
        guard let inactiveCamera = self.inactiveCamera else {
            return false;
        }
        
        do {
           let videoInput = try AVCaptureDeviceInput(device: inactiveCamera)
            
            let videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
            videoDataOutput.alwaysDiscardsLateVideoFrames = false
            
            self.captureSession.beginConfiguration()
            
            self.captureSession.removeInput(self.activeVideoInput)
            if self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
                self.activeVideoInput = videoInput
            } else {
                NSLog("capture session can't add video input %@", videoInput)
            }
            
            self.captureSession.removeOutput(self.activeVideoOutput)
            if self.captureSession.canAddOutput(self.activeVideoOutput) {
                self.captureSession.addOutput(videoDataOutput)
                self.activeVideoOutput = videoDataOutput
            } else {
                NSLog("capture session can't add video output %@", videoInput)
            }
            
            self.videoConnection = videoDataOutput.connection(with: .video)
            self.videoConnection?.videoOrientation = .portrait
            
            self.captureSession.commitConfiguration()
        } catch let error {
            NSLog("\(error)")
            return false
        }
        
        return true
    }
    
    public func focus(at point:CGPoint) {
        let camera = self.activeCamera
        guard !camera.isAdjustingFocus else {
            return
        }
        
        if  camera.isFocusPointOfInterestSupported,
            camera.isFocusModeSupported(.autoFocus)  {
            do {
                try camera.lockForConfiguration()
                camera.focusMode = .autoFocus
                camera.focusPointOfInterest = point
                camera.unlockForConfiguration()
            } catch let error {
                NSLog("%@", error.localizedDescription)
            }
            
            camera.addObserver(self,
                               forKeyPath: focusKeyPath,
                               options: [.new,.old],
                               context: nil)
        } else {
            self.delegate?.focusDidfinish(at: point)
        }
        
    }
    
    // MARK: - Helper
    fileprivate func setupCaptureSession() {
        NotificationCenter.default.addObserver(self, selector: #selector(sessionWasInterrupted(_:)), name: .AVCaptureSessionWasInterrupted, object: nil)
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: self.videoDevice)
            if self.captureSession.canAddInput(videoDeviceInput) {
                self.captureSession.addInput(videoDeviceInput)
                self.activeVideoInput = videoDeviceInput
            }
        } catch let error as NSError {
            NSLog("%@",error)
        }
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
        videoDataOutput.alwaysDiscardsLateVideoFrames = false
        
        if self.captureSession.canAddOutput(videoDataOutput) {
            self.captureSession.addOutput(videoDataOutput)
            self.activeVideoOutput = videoDataOutput
        }
        self.videoConnection = videoDataOutput.connection(with: .video)
        
        self.captureSession.sessionPreset = .high
        
        
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
    
    
    /// 根据位置 获取 捕捉设备
    /// - Parameter position: 设备位置
    fileprivate func videoDevice(in position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devices(for: .video)
        for device in devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    fileprivate func canSwitchCamera() -> Bool {
        return self.cameraCount > 1
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        self.delegate?.didOutputSampleBuffer(sampleBuffer)
    }
    
    // MARK: - Notification selector
    @objc func sessionWasInterrupted(_ notification: Notification) {
        print("Capture session was interrupted with reason: \(notification)")
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath,
              let change = change,
              let obj = object as? AVCaptureDevice else {
            return;
        }
        
        if keyPath == focusKeyPath,
           obj === self.activeCamera  {
            let newValue = change[.newKey] as! Bool
            let oldValue = change[.oldKey] as! Bool
            if newValue == oldValue {
                return
            }
            obj .removeObserver(self, forKeyPath: focusKeyPath)
            self.delegate?.focusDidfinish(at: obj.focusPointOfInterest)
            guard obj.isFocusModeSupported(.continuousAutoFocus) else {
                return
            }
        
            do {
                try obj.lockForConfiguration()
                obj.focusMode = .continuousAutoFocus
                obj.unlockForConfiguration()
            } catch let error {
                NSLog("%@", error.localizedDescription)
            }
            
        }
    }
}
