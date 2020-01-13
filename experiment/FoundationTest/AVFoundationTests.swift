//
//  AVFoundationTests.swift
//  FoundationTest
//
//  Created by birney on 2020/1/8.
//

import XCTest
import AVFoundation
class AVFoundationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeviceSampleRate() {
        let sampleRate = AVAudioSession.sharedInstance().sampleRate
        print("the current device audio sample rate is \(sampleRate)")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
