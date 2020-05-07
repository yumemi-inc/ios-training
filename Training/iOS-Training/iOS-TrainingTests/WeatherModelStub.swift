//
//  WeatherModelStub.swift
//  iOS-TrainingTests
//
//  Created by 酒井 桂哉 on 2020/04/16.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import Foundation
@testable import iOS_Training

class WeatherModelStub: WeatherModel {
    weak var delegate: WeatherModelDelegate?
    var response: WeatherResponse!
    
    func getWeather() {
        delegate?.didGetWeather(result: .success(response), weatherModel: self)
    }
    
    func generateAPIErrorMessage(error: WeatherError) -> String {
        return ""
    }
}
