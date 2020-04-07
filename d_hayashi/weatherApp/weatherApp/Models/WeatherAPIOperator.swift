//
//  WeatherAPIOperator.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/06.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import YumemiWeather

final class WeatherAPIOperator {

    func getWeather(_ area: String) -> Result<WeatherResponse, YumemiWeatherError> {

        let inputString = InputJSON(area: area, date: Date())

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {

            // try encoding
            let inputData = try encoder.encode(inputString)
            let inputJsonString = String(data: inputData, encoding: .utf8)!

            // try decoding
            let resultString: String = try YumemiWeather.fetchWeather(inputJsonString)
            let resultData = Data(resultString.utf8)

            let response: WeatherResponse = try decoder.decode(WeatherResponse.self, from: resultData)

            return .success(response)

        } catch EncodingError.invalidValue {

            return .failure(.invalidParameterError)
        } catch let weatherError as YumemiWeatherError {

            return .failure(weatherError)
        } catch {

            return .failure(.unknownError)
        }
    }
}
