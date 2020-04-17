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

    func getWeather(_ area: String, completionHandler: @escaping WeatherResultHandler) {

        DispatchQueue.global().async {

            let result: Result<WeatherResponse, WeatherAppError>

            do {

                let encodedString = try self.encode(InputJSON(area: area, date: Date()))
                let resultString = try YumemiWeather.syncFetchWeather(encodedString)

                let response: WeatherResponse = try self.decode(resultString)

                result = .success(response)
            } catch WeatherAppError.jsonEncodeSystemError {

                result = .failure(.jsonEncodeSystemError)
            } catch WeatherAppError.decodeSystemError {

                result = .failure(.decodeSystemError)
            } catch let weatherError as YumemiWeatherError {

                switch weatherError {
                case .invalidParameterError:
                    result = .failure(.invalidParameterYumemiError)
                case .jsonDecodeError:
                    result = .failure(.jsonDecodeYumemiError)
                case .unknownError:
                    result = .failure(.unknownYumemiError)
                }
            } catch {

                fatalError()
            }

            completionHandler(result)
        }
    }
}
