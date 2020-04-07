//
//  WeatherAppError.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/07.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

enum WeatherAppError: LocalizedError {

    case unknownAppError
    case jsonEncodeAppError
    case jsonDecodeAppError
    case invalidParameterAppError
}
