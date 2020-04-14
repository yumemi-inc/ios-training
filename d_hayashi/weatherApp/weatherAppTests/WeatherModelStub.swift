//
//  WeatherModelStub.swift
//  weatherAppTests
//
//  Created by 林 大地 on 2020/04/10.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
@testable import weatherApp

class WeatherModelSuccessStub: WeatherModel {

    var delegate: WeatheModelDelegate?

    private var minTemp: Int
    private var maxTemp: Int
    private var weather: WeatherResponse.Weather
    private var date: Date

    init(minTemp: Int, maxTemp: Int, weather: WeatherResponse.Weather, date: Date) {

        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weather = weather
        self.date = date
    }

    func getWeather(_ area: String) {

        let response: WeatherResponse = WeatherResponse.init(maxTemp: self.maxTemp, minTemp: self.minTemp, date: self.date, weather: self.weather)

        delegate?.didGetWeather(.success(response))
    }
}
