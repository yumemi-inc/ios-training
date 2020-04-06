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

    private var inputJsonString = #"{ "area": "tokyo", "date": "2020-04-01T12:00:00+09:00" }"#

    func getWeather(_ area: String) -> Result<WeatherResponse, YumemiWeatherError> {

        let inputString = InputJSON(area: area, date: Date())

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        // input encoding
        do {

            let inputData = try encoder.encode(inputString)
            inputJsonString = String(data: inputData, encoding: .utf8)!
        } catch {

            debugPrint("encoding error")
            return .failure(.invalidParameterError)
        }

        // output decoding
        do {

            let resultString: String = try YumemiWeather.fetchWeather(inputJsonString)
            guard let resultData = resultString.data(using: .utf8) else {

                return .failure(.unknownError)
            }

            let response: WeatherResponse = try decoder.decode(WeatherResponse.self, from: resultData)

            return .success(response)

        } catch let weatherError as YumemiWeatherError {

            return .failure(weatherError)
        } catch {

            return .failure(.unknownError)
        }
    }
}
