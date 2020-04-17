//
//  iOS_TrainingTests.swift
//  iOS-TrainingTests
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import XCTest
@testable import iOS_Training

class iOS_TrainingTests: XCTestCase {
    
    var weatherViewController: WeatherViewController!
    var weatherModel: WeatherModelStub!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        weatherViewController = storyboard.instantiateViewController(identifier: "WeatherViewController", creator: { (coder) -> WeatherViewController? in
            WeatherViewController.init(coder: coder)
        })
        weatherModel = WeatherModelStub()
        weatherViewController.weatherModel = weatherModel
        
        weatherViewController.loadViewIfNeeded()
        weatherViewController.view.layoutIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_天気がsunnyだったら_画面に晴れ画像が表示される() throws {
        let response = WeatherResponse(weather: .sunny, maxTemp: 20, minTemp: -20, date: Date())
        self.weatherModel.response = response
        weatherViewController.operateChangeWeatherView()
        
        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysTemplate)
        XCTAssertEqual(actual, expected)
    }
    
    func test_天気予報がcloudyだったら_画面に曇り画像が表示される() throws {
        let response = WeatherResponse(weather: .cloudy, maxTemp: 20, minTemp: -20, date: Date())
        self.weatherModel.response = response
        weatherViewController.operateChangeWeatherView()
        
        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "cloudy").withRenderingMode(.alwaysTemplate)
        XCTAssertEqual(actual, expected)
    }
    
    func test_天気予報がrainyだったら_画面に雨画像が表示される() throws {
        let response = WeatherResponse(weather: .rainy, maxTemp: 20, minTemp: -20, date: Date())
        self.weatherModel.response = response
        weatherViewController.operateChangeWeatherView()
        
        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "rainy").withRenderingMode(.alwaysTemplate)
        XCTAssertEqual(actual, expected)
    }
    
    func test_天気予報の最高気温がUILabelに反映される() throws {
        let response = WeatherResponse(weather: .rainy, maxTemp: 20, minTemp: -20, date: Date())
        self.weatherModel.response = response
        weatherViewController.operateChangeWeatherView()
        
        let actual = weatherViewController.maxTemperatureLabel.text
        let expected = "20"
        XCTAssertEqual(actual, expected)
    }
    
    func test_天気予報の最低い気温がUILabelに反映される() throws {
        let response = WeatherResponse(weather: .rainy, maxTemp: 20, minTemp: -20, date: Date())
        self.weatherModel.response = response
        weatherViewController.operateChangeWeatherView()
        
        let actual = weatherViewController.minTemperatureLabel.text
        let expected = "-20"
        XCTAssertEqual(actual, expected)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
