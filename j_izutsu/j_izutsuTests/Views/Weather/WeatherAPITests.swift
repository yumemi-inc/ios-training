//
//  WeatherAPITests.swift
//  j_izutsuTests
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import XCTest
@testable import j_izutsu

class WeatherAPITests: XCTestCase {
    var weatherViewController: WeatherViewController?
    
    override func setUpWithError() throws {
        guard let weatherVC = WeatherViewBuilder.create() as? WeatherViewController else { return }
        self.weatherViewController = weatherVC
        self.weatherViewController?.loadViewIfNeeded()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
