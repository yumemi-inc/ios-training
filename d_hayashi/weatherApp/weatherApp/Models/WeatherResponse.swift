//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/03.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import YumemiWeather

struct WeatherResponse: Decodable {
    let maxTemp: Int
    let minTemp: Int
    let date: Date
    let weather: String
}

struct InputJSON: Encodable {
    let area: String
    let date: Date
}
