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
    case resourceNameError
}

extension WeatherAppError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .unknownAppError:
            return "unknown error"
        case .jsonEncodeAppError:
            return "encoding error"
        case .jsonDecodeAppError:
            return "decoding error"
        case .invalidParameterAppError:
            return "input parameter error"
        case .resourceNameError:
            return "resource name error"
        }
    }
}
