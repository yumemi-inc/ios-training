//
//  WeatherAPI.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/25.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation
import YumemiWeather


protocol WeatherAPIModel {
    func fetchWeather(area: String, completionHandler: @escaping (Result<WeatherResponse, WeatherAPIError>) -> Void)
}

class WeatherAPI: WeatherAPIModel {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    func fetchWeather(area: String, completionHandler: @escaping (Result<WeatherResponse, WeatherAPIError>) -> Void) {
        let input = InputData(area: area, date: Date())
        
        DispatchQueue.global().async {
            let result: Result<WeatherResponse, WeatherAPIError>
            do {
                let inputData = try self.encoder.encode(input)
                
                guard let inputJsonStr = String(data: inputData, encoding: .utf8) else {
                    result = .failure(.invalidParameterError)
                    completionHandler(result)
                    return
                }
                
                let resultStr = try YumemiWeather.syncFetchWeather(inputJsonStr)
                let response = try self.decoder.decode(WeatherResponse.self, from: Data(resultStr.utf8))
                
                result = .success(response)
            } catch is EncodingError {
                result = .failure(.jsonEncodeError)
            } catch is DecodingError {
                result = .failure(.jsonDecodeError)
            } catch let error as YumemiWeatherError {
                switch error {
                case .invalidParameterError:
                    result = .failure(.invalidParameterError)
                case .jsonDecodeError:
                    result = .failure(.jsonDecodeError)
                case .unknownError:
                    result = .failure(.unknownError)
                }
            } catch {
                result = .failure(.unknownError)
            }
            
            completionHandler(result)
        }
    }
}
