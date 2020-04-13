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
    
    private func decodeWeatherResponse(from: Foundation.Data) throws -> WeatherResponse {
        let weather: WeatherResponse
        do {
            weather = try WeatherAPI.decoder.decode(WeatherResponse.self, from: from)
        } catch {
            throw WeatherError.jsonDecodeError
        }
        return weather
    }
    
    private func encodeData(parameter: WeatherParameter) throws -> Foundation.Data {
        let parameterJson: Foundation.Data
        do {
            parameterJson = try WeatherAPI.encoder.encode(parameter)
        } catch {
            throw WeatherError.jsonEncodeError
        }
        return parameterJson
    }
    
    private func convertWeatherError(yumemiError: YumemiWeatherError) -> WeatherError {
        let weatherError: WeatherError
        switch yumemiError {
        case .invalidParameterError:
            weatherError = WeatherError.invalidParameterError
        case .jsonDecodeError:
            weatherError = WeatherError.jsonDecodeError
        case .unknownError:
            weatherError = WeatherError.unknownError
        }
        return weatherError
    }
    
    func getWeather() -> Result<Weather, WeatherError>{
        let parameter = WeatherParameter(area: "tokyo", date: Date())
        do {
            let requestData = try WeatherAPI.encoder.encode(parameter)
            guard let requestJson = String(data: requestData, encoding: .utf8) else {
                return .failure(.invalidParameterError)
            }
            let responseJson = try YumemiWeather.fetchWeather(requestJson)
            let response = try WeatherAPI.decoder.decode(WeatherResponse.self, from: Data(responseJson.utf8))
            return .success(response.weather)
        } catch is EncodingError {
            return .failure(.jsonEncodeError)
        } catch is DecodingError {
            return .failure(.jsonDecodeError)
        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                return .failure(.invalidParameterError)
            case .jsonDecodeError:
                return .failure(.jsonDecodeError)
            case .unknownError:
                return .failure(.unknownError)
            }
        } catch {
            return .failure(.unknownError)
        }
    }
    
    func generateAPIErrorMessage (error: WeatherError) -> String {
        return error.toString
    }
}
