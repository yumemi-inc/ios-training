//
//  WeatherModel.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/10.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

protocol WeatherModel {

    var delegate: WeatheModelDelegate? { get set }
    func getWeather(_ area: String)
}
