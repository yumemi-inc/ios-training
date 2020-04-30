//
//  WeatherModel.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/16.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation

enum Weather: String, Codable {
    case sunny
    case cloudy
    case rainy
}

enum WeatherError: Error {
    case invalidParameterError
    case invalidResponseError
    case jsonDecodeError
    case jsonEncodeError
    case unknownError
    
    var toString: String {
        switch self {
        case .invalidParameterError:
            return "invalidParameterError"
        case .invalidResponseError:
            return "invalidResponseError"
        case .jsonDecodeError:
            return "jsonDecodeError"
        case .jsonEncodeError:
            return "jsonEncodeError"
        case .unknownError:
            return "unknownError"
        }
    }
}

struct WeatherParameter: Codable {
    let area: String
    let date: Date
}

struct WeatherResponse: Codable {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int
    let date: Date
}

protocol WeatherModel {
    func getWeather(completion: @escaping(_ result: Result<WeatherResponse, WeatherError>) -> ())
    func generateAPIErrorMessage (error: WeatherError) -> String
}
