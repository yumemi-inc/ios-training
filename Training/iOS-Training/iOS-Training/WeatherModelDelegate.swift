//
//  WeatherModelDelegate.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/05/01.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation

protocol WeatherModelDelegate: class {
    func didGetWeather(result: Result<WeatherResponse, WeatherError>, weatherModel: WeatherModel)
}
