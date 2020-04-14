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

    var weatherViewController: WeatherViewController!

    override func setUpWithError() throws {

        let weatherStoryboard = UIStoryboard(name: "WeatherView", bundle: nil)
        weatherViewController = weatherStoryboard.instantiateViewController(identifier: "WeatherViewController")
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

    func test晴れに対応した画像が表示される() {

        weatherViewController.weatherModel = WeatherModelSuccessStub.init(minTemp: -40, maxTemp: 40, weather: .sunny, date: Date())
        weatherViewController.weatherModel?.delegate = weatherViewController
        weatherViewController.contactWeatherAPI()

        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysTemplate)

        XCTAssertEqual(actual, expected)
    }

    func test曇りに対応した画像が表示される() {

        weatherViewController.weatherModel = WeatherModelSuccessStub.init(minTemp: -40, maxTemp: 40, weather: .cloudy, date: Date())
        weatherViewController.weatherModel?.delegate = weatherViewController
        weatherViewController.contactWeatherAPI()

        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "cloudy").withRenderingMode(.alwaysTemplate)

        XCTAssertEqual(actual, expected)
    }

    func test雨に対応した画像が表示される() {

        weatherViewController.weatherModel = WeatherModelSuccessStub.init(minTemp: -40, maxTemp: 40, weather: .rainy, date: Date())
        weatherViewController.weatherModel?.delegate = weatherViewController
        weatherViewController.contactWeatherAPI()

        let actual = weatherViewController.weatherImageView.image
        let expected = #imageLiteral(resourceName: "rainy").withRenderingMode(.alwaysTemplate)

        XCTAssertEqual(actual, expected)
    }


    func test最高気温がUILabelに反映される() {

        weatherViewController.weatherModel = WeatherModelSuccessStub.init(minTemp: -40, maxTemp: 40, weather: .sunny, date: Date())
        weatherViewController.weatherModel?.delegate = weatherViewController
        weatherViewController.contactWeatherAPI()

        let actual = weatherViewController.maxTempLabel.text
        let expected = "40 ˚C"

        XCTAssertEqual(actual, expected)
    }

    func test最低気温がUILabelに反映される() {

        weatherViewController.weatherModel = WeatherModelSuccessStub.init(minTemp: -40, maxTemp: 40, weather: .sunny, date: Date())
        weatherViewController.weatherModel?.delegate = weatherViewController
        weatherViewController.contactWeatherAPI()

        let actual = weatherViewController.minTempLabel.text
        let expected = "-40 ˚C"

        XCTAssertEqual(actual, expected)
    }

    func testJSONエンコード() {

        let weatherModel = WeatherModelImpl()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "ja_JP")
        let date = formatter.date(from: "2020-04-01T12:00:00+09:00")!

        let actual: String
        let expected = #"{"date":"2020-04-01T03:00:00Z","area":"tokyo"}"#

        do {
            actual = try weatherModel.encode(InputJSON(area: "tokyo", date: date))
            XCTAssertEqual(actual, expected)
        } catch {
            XCTFail("test encode faild")
        }
    }

    func testJSONデコード() {

        let weatherModel = WeatherModelImpl()

        let testInput = """
        {
            "weather": "sunny",
            "max_temp": 40,
            "min_temp": -40,
            "date": "2020-04-01T12:00:00+09:00"
        }
        """

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "ja_JP")
        let date = formatter.date(from: "2020-04-01T12:00:00+09:00")!

        let actual: WeatherResponse

        do {
            actual = try weatherModel.decode(testInput)
            print(actual)
            let expected = WeatherResponse(maxTemp: 40, minTemp: -40, date: date, weather: .sunny)

            XCTContext.runActivity(named: "各プロパティ") { _ in
                XCTContext.runActivity(named: "weather") { _ in
                    XCTAssertEqual(actual.weather, expected.weather)
                }
                XCTContext.runActivity(named: "maxTemp") { _ in
                    XCTAssertEqual(actual.maxTemp, expected.maxTemp)
                }
                XCTContext.runActivity(named: "minTemp") { _ in
                    XCTAssertEqual(actual.minTemp, expected.minTemp)
                }
                XCTContext.runActivity(named: "date") { _ in
                    XCTAssertEqual(actual.date, expected.date)
                }
            }
        } catch {
            XCTFail("test encode faild")
        }
    }
}
