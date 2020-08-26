//
//  WeatherAPI.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/25.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation
import YumemiWeather


class WeatherAPI {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    func fetchWeather(area: String) -> Result<WeatherResponse, WeatherAPIError> {
        let input = InputData(area: area, date: Date())
        
        do {
            let inputData = try self.encoder.encode(input)
            
            guard let inputJsonStr = String(data: inputData, encoding: .utf8) else { return .failure(.invalidParameterError)
            }
            
            let resultStr = try YumemiWeather.fetchWeather(inputJsonStr)
            let response = try self.decoder.decode(WeatherResponse.self, from: Data(resultStr.utf8))
            
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
}
