//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/03.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let maxTemp: Int
    let minTemp: Int
    let date: Date
    let weather: String
}
