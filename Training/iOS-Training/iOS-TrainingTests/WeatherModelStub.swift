//
//  WeatherModelStub.swift
//  iOS-TrainingTests
//
//  Created by 酒井 桂哉 on 2020/04/16.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation
@testable import iOS_Training

class WeatherModelStub: WeatherModel {
    
    let weatherModel = WeatherModelImpl()
    
    private var minTemp: Int
    private var maxTemp: Int
    private var weather: Weather
    
    init(minTemp: Int, maxTemp: Int, weather: Weather) {
        self.maxTemp = minTemp
        self.maxTemp = maxTemp
        self.weather = weather
    }
    
    func getWeather() -> Result<WeatherResponse, WeatherError> {
        weatherModel.getWeather()
    }
    
    func generateAPIErrorMessage(error: WeatherError) -> String {
        return ""
    }
}
