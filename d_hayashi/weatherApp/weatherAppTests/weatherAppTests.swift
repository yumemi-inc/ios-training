//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by 林 大地 on 2020/04/02.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import XCTest
@testable import weatherApp

class weatherAppTests: XCTestCase {

    var weatherViewController = WeatherViewController()

    override func setUpWithError() throws {

        let weatherStoryboard = UIStoryboard(name: "WeatherViewController", bundle: nil)
        weatherViewController = weatherStoryboard.instantiateViewController(identifier: "WeatherViewController") as! WeatherViewController
        weatherViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
