//
//  WeatherResponse.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/16.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int
    let date: Date
}
