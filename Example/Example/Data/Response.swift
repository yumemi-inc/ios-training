//
//  Response.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/03/31.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let weatherCondition: Weather
    let maxTemperature: Int
    let minTemperature: Int
    let date: Date
}
