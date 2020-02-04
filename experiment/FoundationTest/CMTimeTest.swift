//
//  CMTimeTest.swift
//  FoundationTest
//
//  Created by birney on 2019/8/27.
//

import XCTest
import CoreMedia

class CMTimeTest: XCTestCase {
    var masterClock: CMClock! = nil
    var startTime:CMTime! = nil
    
    override func setUp() {
        masterClock = CMClockGetHostTimeClock()
        startTime = CMClockGetTime(masterClock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCMClock() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for _ in 0...1000 {
            usleep(3300)
            //sleep(1)
            let endTime = CMClockGetTime(masterClock)
            let diff = CMTimeSubtract(endTime, startTime)
            CMTimeShow(diff)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
