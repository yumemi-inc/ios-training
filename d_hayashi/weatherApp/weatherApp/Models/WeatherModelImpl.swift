//
//  WeatherAPIOperator.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/06.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import YumemiWeather

final class WeatherModelImpl: WeatherModel {

    func encode(_ input: InputJSON) throws -> String {

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        do {

            let result = try encoder.encode(input)
            return String(data: result, encoding: .utf8)!
        } catch {

            throw WeatherAppError.jsonEncodeSystemError
        }
    }

    func decode(_ input: String) throws -> WeatherResponse {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {

            let inputData = Data(input.utf8)
            let response = try decoder.decode(WeatherResponse.self, from: inputData)
            return response
        } catch {

            throw WeatherAppError.decodeSystemError
        }
    }

    func getWeather(_ area: String, completionHandler: @escaping (Result<WeatherResponse, WeatherAppError>) -> Void) {

        DispatchQueue.global().async {

            do {

                let encodedString = try self.encode(InputJSON(area: area, date: Date()))
                let resultString = try YumemiWeather.syncFetchWeather(encodedString)

                let response: WeatherResponse = try self.decode(resultString)

                completionHandler(.success(response))
            } catch WeatherAppError.jsonEncodeSystemError {

                completionHandler(.failure(.jsonEncodeSystemError))
            } catch WeatherAppError.decodeSystemError {

                completionHandler(.failure(.decodeSystemError))
            } catch let weatherError as YumemiWeatherError {

                switch weatherError {
                case .invalidParameterError:
                    completionHandler(.failure(.invalidParameterYumemiError))
                case .jsonDecodeError:
                    completionHandler(.failure(.jsonDecodeYumemiError))
                case .unknownError:
                    completionHandler(.failure(.unknownYumemiError))
                }
            } catch {

                fatalError()
            }
        }
    }
}
