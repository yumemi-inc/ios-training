//
//  WeatherResponse.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/19.
//

import UIKit

struct WeatherResponse: Decodable {
    let date: String
    let minTemp: Int
    let maxTemp: Int
    let weather: String
}
