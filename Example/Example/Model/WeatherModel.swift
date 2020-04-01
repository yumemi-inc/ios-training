//
//  WeatherModel.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/04/01.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import YumemiWeather

protocol WeatherModel {
    func fetchWeather(_ request: Request) throws -> Response
}

enum WeatherModelError: Error {
    case jsonEncodeError
    case jsonDecodeError
}

class WeatherModelImpl: WeatherModel {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
    
    func jsonString(from request: Request) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        let requestData = try encoder.encode(request)
        guard let requestJsonString = String(data: requestData, encoding: .utf8) else {
            throw WeatherModelError.jsonEncodeError
        }
        return requestJsonString
    }
    
    func response(from jsonString: String) throws -> Response {
        guard let responseData = jsonString.data(using: .utf8) else {
            throw WeatherModelError.jsonDecodeError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: responseData)
    }
    
    func fetchWeather(_ request: Request) throws -> Response {
        let requestJson = try jsonString(from: request)
        let responseJson = try YumemiWeather.fetchWeather(requestJson)
        return try response(from: responseJson)
    }
    
}
