//
//  WeatherModel.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/09.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

protocol WeatherModel: AnyObject {

    func weatherViewUpdate(_ weatherInfo: WeatherResponse)
    func showErrorAlert(_ error: WeatherAppError)
}
