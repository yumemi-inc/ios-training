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

    var delegate: WeatherModel?

    func getWeather(_ area: String) {

        let inputJsonString = InputJSON(area: area, date: Date())

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {

            // try encoding
            let inputData = try encoder.encode(inputJsonString)
            let inputJsonString = String(data: inputData, encoding: .utf8)!

            // try decoding
            let resultString = try YumemiWeather.fetchWeather(inputJsonString)
            let resultData = Data(resultString.utf8)

            let response: WeatherResponse = try decoder.decode(WeatherResponse.self, from: resultData)

            delegate?.weatherViewUpdate(response)
        } catch EncodingError.invalidValue {

            delegate?.showErrorAlert(.jsonEncodeSystemError)
        } catch let weatherError as YumemiWeatherError {

            switch weatherError {
            case .invalidParameterError:
                delegate?.showErrorAlert(.invalidParameterYumemiError)
            case .jsonDecodeError:
                delegate?.showErrorAlert(.jsonDecodeYumemiError)
            case .unknownError:
                delegate?.showErrorAlert(.unknownYumemiError)
            }
        } catch let DecodingError.dataCorrupted(context) {

            debugPrint(context)
            delegate?.showErrorAlert(.decodeSystemError)
        } catch {

            delegate?.showErrorAlert(.unknownSystemError)
        }
    }
}
