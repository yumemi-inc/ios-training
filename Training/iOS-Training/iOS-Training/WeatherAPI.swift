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

enum WeatherError: Error {
    case notExistsError
    case invalidParameterError
    case jsonDecodeError
    case jsonEncodeError
    case unknownError
}

class WeatherAPI {
    func getWeather() -> Result<String, WeatherError>{
        let parameter = WeatherParameter(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        var parameterJson: Foundation.Data
        do {
            parameterJson = try JSONEncoder().encode(parameter)
        } catch {
            return .failure(WeatherError.jsonEncodeError)
        }
        let parameterString = String(data: parameterJson, encoding: .utf8)!
        
        var response: String
        do {
            response = try YumemiWeather.fetchWeather(parameterString)
        } catch YumemiWeatherError.invalidParameterError {
            return .failure(WeatherError.invalidParameterError)
        } catch YumemiWeatherError.jsonDecodeError {
            return .failure(WeatherError.jsonDecodeError)
        } catch YumemiWeatherError.unknownError {
            return .failure(WeatherError.unknownError)
        } catch {
            return .failure(WeatherError.jsonEncodeError)
        }
        
        guard let responseJson = response.data(using: .utf8) else {
            return .failure(WeatherError.invalidParameterError)
        }
        
        var weather: WeatherResponse
        do {
            weather = try JSONDecoder().decode(WeatherResponse.self, from: responseJson)
        } catch {
            return .failure(WeatherError.jsonDecodeError)
        }
        return .success(weather.weather)
    }
    
    func generateAPIErrorMessage (error: WeatherError) -> String {
        var errorMessage: String
        switch error {
        case WeatherError.invalidParameterError:
            errorMessage = "invalidParameterError"
            
        case WeatherError.jsonDecodeError:
            errorMessage = "jsonDecodeError"
            
        case WeatherError.jsonEncodeError:
            errorMessage = "jsonEncodeError"
            
        case WeatherError.notExistsError:
            errorMessage = "notExistsError"
            
        case WeatherError.unknownError:
            errorMessage = "unknownError"
        }
        return errorMessage
    }
}
