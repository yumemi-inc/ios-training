//
//  WeatherAPIOperatorDelegate.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/09.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

protocol WeatheModelDelegate: AnyObject {

    func didGetWeather(_ result: Result<WeatherResponse, WeatherAppError>)
}
