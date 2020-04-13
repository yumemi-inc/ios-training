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

enum Weather: String, Codable {
    case sunny
    case cloudy
    case rainy
}

enum WeatherError: Error {
    case notExistsError
    case invalidParameterError
    case invalidResponseError
    case jsonDecodeError
    case jsonEncodeError
    case unknownError
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

class WeatherAPI {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    func getWeather() -> Result<Weather, WeatherError>{
        let area = "tokyo"
        let date = Date()
        
        let parameter = WeatherParameter(area: area, date: date)
        
        let parameterJson: Foundation.Data
        do {
            parameterJson = try WeatherAPI.encoder.encode(parameter)
        } catch {
            return .failure(WeatherError.jsonEncodeError)
        }
        
        let parameterString = String(data: parameterJson, encoding: .utf8)!
        
        let response: String
        do {
            response = try YumemiWeather.fetchWeather(parameterString)
        } catch YumemiWeatherError.invalidParameterError {
            return .failure(WeatherError.invalidParameterError)
        } catch YumemiWeatherError.jsonDecodeError {
            return .failure(WeatherError.jsonDecodeError)
        } catch {
            return .failure(WeatherError.unknownError)
        }
        
        guard let responseJson = response.data(using: .utf8) else {
            return .failure(WeatherError.invalidResponseError)
        }
        
        let weather: WeatherResponse
        do {
            weather = try WeatherAPI.decoder.decode(WeatherResponse.self, from: responseJson)
        } catch {
            return .failure(WeatherError.jsonDecodeError)
        }
        return .success(weather.weather)
    }
    
    func generateAPIErrorMessage (error: WeatherError) -> String {
        let errorMessage: String
        switch error {
        case WeatherError.invalidParameterError:
            errorMessage = "invalidParameterError"
            
        case WeatherError.invalidResponseError:
            errorMessage = "invalidResponseError"
            
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
