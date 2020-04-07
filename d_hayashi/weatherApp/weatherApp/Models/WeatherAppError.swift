//
//  WeatherAppError.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/07.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

enum WeatherAppError: Error {

    case unknownAppError
    case jsonEncodeAppError
    case jsonDecodeAppError
    case invalidParameterAppError
}

extension WeatherAppError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .unknownAppError:
            return "unknown error happend"
        case .jsonEncodeAppError:
            return "encoding input parameter to json error"
        case .jsonDecodeAppError:
            return "decoding json responce to string error"
        case .invalidParameterAppError:
            return "input parameter is wrong"
        }
    }
}
