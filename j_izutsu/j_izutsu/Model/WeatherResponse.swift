//
//  WeatherResponse.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/25.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation


struct InputData: Codable {
    let area: String
    let date: Date
}

enum Weather: String, Codable {
    case sunny
    case cloudy
    case rainy
}

struct WeatherResponse: Codable {
    let maxTemp: Int
    let minTemp: Int
    let date: Date
    let weather: Weather
}

enum WeatherAPIError: Error {
    case invalidParameterError
    case jsonDecodeError
    case jsonEncodeError
    case unknownError
}

extension WeatherAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidParameterError: return "invalid Parameter error"
        case .jsonDecodeError: return "json decode error"
        case .jsonEncodeError: return "json encode error"
        case .unknownError: return "unknown error happened"
        }
    }
}
