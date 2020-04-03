//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/03.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    // TODO: スネークケース -> キャメルケースへ
    let max_temp: Int
    let min_temp: Int
    let date: String
    let weather: String
}
