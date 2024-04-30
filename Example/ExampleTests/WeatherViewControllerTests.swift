//
//  WeatherViewControllerTests.swift
//  ExampleTests
//
//  Created by 渡部 陽太 on 2020/04/01.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
import YumemiWeather
@testable import Example

class WeatherViewControllerTests: XCTestCase {

    var weahterViewController: WeatherViewController!
    var weahterModel: WeatherModelMock!
    
    override func setUpWithError() throws {
        weahterModel = WeatherModelMock()
        weahterViewController = R.storyboard.weather.instantiateInitialViewController()!
        weahterViewController.weatherModel = weahterModel
        weahterViewController.disasterModel = DisasterModelMock()
        
        _ = weahterViewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func test_天気予報がsunnyだったらImageViewのImageにsunnyが設定されること_TintColorがredに設定されること() async throws {
        weahterModel.fetchWeatherImpl = { _ in
            let response = Response(weather: .sunny, maxTemp: 0, minTemp: 0, date: Date())
            return Result.success(response)
        }
        
        weahterViewController.loadWeather(self)
        await Task.yield()

        XCTAssertEqual(weahterViewController.weatherImageView.tintColor, R.color.red())
        XCTAssertEqual(weahterViewController.weatherImageView.image, R.image.sunny())
    }
    
    @MainActor
    func test_天気予報がcloudyだったらImageViewのImageにcloudyが設定されること_TintColorがgrayに設定されること() async throws {
        weahterModel.fetchWeatherImpl = { _ in
            let response = Response(weather: .cloudy, maxTemp: 0, minTemp: 0, date: Date())
            return Result.success(response)
        }
        
        weahterViewController.loadWeather(self)
        await Task.yield()
        
        XCTAssertEqual(weahterViewController.weatherImageView.tintColor, R.color.gray())
        XCTAssertEqual(weahterViewController.weatherImageView.image, R.image.cloudy())
    }
    
    @MainActor
    func test_天気予報がrainyだったらImageViewのImageにrainyが設定されること_TintColorがblueに設定されること() async throws {
        weahterModel.fetchWeatherImpl = { _ in
            let response = Response(weather: .rainy, maxTemp: 0, minTemp: 0, date: Date())
            return Result.success(response)
        }
        
        weahterViewController.loadWeather(self)
        await Task.yield()
        
        XCTAssertEqual(weahterViewController.weatherImageView.tintColor, R.color.blue())
        XCTAssertEqual(weahterViewController.weatherImageView.image, R.image.rainy())
    }
    
    @MainActor
    func test_最高気温_最低気温がUILabelに設定されること() async throws {
        weahterModel.fetchWeatherImpl = { _ in
            let response = Response(weather: .rainy, maxTemp: 100, minTemp: -100, date: Date())
            return Result.success(response)
        }
        
        weahterViewController.loadWeather(self)
        await Task.yield()
        
        XCTAssertEqual(weahterViewController.minTempLabel.text, "-100")
        XCTAssertEqual(weahterViewController.maxTempLabel.text, "100")
    }
}

class WeatherModelMock: WeatherModel {
    
    var fetchWeatherImpl: ((Request) -> Result<Response, WeatherError>)!
    
    func fetchWeather(at area: String, date: Date, completion: @escaping (Result<Response, WeatherError>) -> Void) {
        completion(fetchWeatherImpl(Request(area: area, date: date)))
    }
}

final class DisasterModelMock: DisasterModel {

    func fetchDisaster(completion: ((String) -> Void)?) {
        completion?("只今、災害情報はありません。")
    }
}
