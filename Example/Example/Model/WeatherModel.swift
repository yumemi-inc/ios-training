//
//  WeatherModel.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/04/01.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import YumemiWeather

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
            throw WeatherError.jsonEncodeError
        }
        return requestJsonString
    }
    
    func response(from jsonString: String) throws -> Response {
        guard let responseData = jsonString.data(using: .utf8) else {
            throw WeatherError.jsonDecodeError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: responseData)
    }
    
    func fetchWeather(request: Request) -> Result<Response, WeatherError> {
        do {
            let requestJson = try jsonString(from: request)
            let responseJson = try YumemiWeather.syncFetchWeather(requestJson)
            let response = try self.response(from: responseJson)
            return .success(response)
        } catch WeatherError.jsonEncodeError {
            return .failure(.jsonEncodeError)
        } catch YumemiWeatherError.unknownError {
            return .failure(.unknownError)
        } catch WeatherError.jsonDecodeError {
            return .failure(.jsonDecodeError)
        } catch {
            return .failure(.unknownError)
        }
    }
    
    func getWeather(at area: String, date: Date, completion: @escaping (Result<Response, WeatherError>) -> Void) {
        let request = Request(area: area, date: date)
        DispatchQueue.global().async {
            let result = self.fetchWeather(request: request)
            completion(result)
        }
    }
}
