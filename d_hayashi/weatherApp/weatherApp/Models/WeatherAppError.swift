//
//  WeatherAppError.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/07.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

enum WeatherAppError: Error {

    case unknownYumemiError
    case jsonEncodeSystemError
    case jsonDecodeYumemiError
    case invalidParameterYumemiError
    case resourceNameSystemError
    case unknownSystemError
    case decodeSystemError
}

extension WeatherAppError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .unknownYumemiError:
            return "unknown Yumemi error"
        case .jsonEncodeSystemError:
            return "encoding faild"
        case .jsonDecodeYumemiError:
            return "decoding Yumemi error"
        case .invalidParameterYumemiError:
            return "input parameter Yumemi error"
        case .resourceNameSystemError:
            return "resource name system error"
        case .unknownSystemError:
            return "unknown system error"
        case .decodeSystemError:
            return "faild to decode"
        }
    }
}
