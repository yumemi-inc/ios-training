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

    weak var delegate: WeatheModelDelegate?

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

    func getWeather(_ area: String) {

        DispatchQueue.global().async {

            do {

                let encodedString = try self.encode(InputJSON(area: area, date: Date()))
                let resultString = try YumemiWeather.syncFetchWeather(encodedString)

                let response: WeatherResponse = try self.decode(resultString)

                DispatchQueue.main.async {
                    self.delegate?.didGetWeather(.success(response))
                }
            } catch WeatherAppError.jsonEncodeSystemError {

                DispatchQueue.main.async {
                    self.delegate?.didGetWeather(.failure(.jsonEncodeSystemError))
                }
            } catch WeatherAppError.decodeSystemError {

                self.delegate?.didGetWeather(.failure(.decodeSystemError))
            } catch let weatherError as YumemiWeatherError {

                switch weatherError {
                case .invalidParameterError:
                    DispatchQueue.main.async {
                        self.delegate?.didGetWeather(.failure(.invalidParameterYumemiError))
                    }
                case .jsonDecodeError:
                    DispatchQueue.main.async {
                        self.delegate?.didGetWeather(.failure(.jsonDecodeYumemiError))
                    }
                case .unknownError:
                    DispatchQueue.main.async {
                        self.delegate?.didGetWeather(.failure(.unknownYumemiError))
                    }
                }
            } catch {

                DispatchQueue.main.async {
                    self.delegate?.didGetWeather(.failure(.unknownSystemError))
                }
            }
        }

    }
}
