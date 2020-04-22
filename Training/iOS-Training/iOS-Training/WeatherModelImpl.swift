//
//  WeatherModelImpl.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/16.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation
import YumemiWeather

class WeatherModelImpl: WeatherModel {
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
    
    func getWeather() -> Result<WeatherResponse, WeatherError>{
        let parameter = WeatherParameter(area: "tokyo", date: Date())
        do {
            let requestData = try WeatherModelImpl.encoder.encode(parameter)
            guard let requestJson = String(data: requestData, encoding: .utf8) else {
                return .failure(.invalidParameterError)
            }
            let responseJson = try YumemiWeather.syncFetchWeather(requestJson)
            let response = try WeatherModelImpl.decoder.decode(WeatherResponse.self, from: Data(responseJson.utf8))
            return .success(response)
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
