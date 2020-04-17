//
//  WeatherModel.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/10.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

typealias WeatherResultHandler = Optional<(Result<WeatherResponse, WeatherAppError>) -> Void?>

protocol WeatherModel {

    func getWeather(_ area: String, completionHandler: WeatherResultHandler)
}
