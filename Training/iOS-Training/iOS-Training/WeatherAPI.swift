//
//  WeatherAPI.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/08.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation
import YumemiWeather

struct WeatherParameter: Codable {
    let area: String
    let date: String
}

struct WeatherResponse: Codable {
    let max_temp: Int
    let date: String
    let min_temp: Int
    let weather: String
}

class WeatherAPI {
    func getWeather() -> Result<String, YumemiWeatherError>{
        let parameter = WeatherParameter(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        let parameterJson = try! JSONEncoder().encode(parameter)
        let parameterString = String(data: parameterJson, encoding: .utf8)!
    
        var weather: WeatherResponse
        do {
            let response = try YumemiWeather.fetchWeather(parameterString)
            let responseJson = response.data(using: .utf8)
            weather = try! JSONDecoder().decode(WeatherResponse.self, from: responseJson!)
        } catch YumemiWeatherError.invalidParameterError {
            return Result.failure(YumemiWeatherError.invalidParameterError)
        } catch YumemiWeatherError.jsonDecodeError {
            return Result.failure(YumemiWeatherError.jsonDecodeError)
        } catch {
            return Result.failure(YumemiWeatherError.unknownError)
        }
        return Result.success(weather.weather)
    }
}
