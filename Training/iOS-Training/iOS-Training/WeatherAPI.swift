//
//  WeatherAPI.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/08.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit
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

enum WeatherColorError: Error {
    case notExistsError
}

class WeatherAPI {
    let weatherColorDictionary = [
        "sunny": UIColor.red,
        "cloudy": UIColor.gray,
        "rainy": UIColor.blue
    ]
    
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
            return .failure(.invalidParameterError)
        } catch YumemiWeatherError.jsonDecodeError {
            return .failure(.jsonDecodeError)
        } catch {
            return .failure(.unknownError)
        }
        return .success(weather.weather)
    }
    
    func generateAPIErrorMessage (error: YumemiWeatherError) -> String {
        var errorMessage: String
        switch error {
        case YumemiWeatherError.invalidParameterError:
            errorMessage = "invalidParameterError"
        case YumemiWeatherError.jsonDecodeError:
            errorMessage = "jsonDecodeError"
        case YumemiWeatherError.unknownError:
            errorMessage = "unknownError"
        }
        return errorMessage
    }
    
    func getWeatherColor(weather: String) -> Result<UIColor, WeatherColorError> {
        guard let color = weatherColorDictionary[weather] else {
            return .failure(WeatherColorError.notExistsError)
        }
        return .success(color)
    }
    
    func generateColorErrorMessage (error: WeatherColorError) -> String {
        var errorMessage: String
        switch error {
        case WeatherColorError.notExistsError:
            errorMessage = "notExistsError"
        }
        return errorMessage
    }
}
