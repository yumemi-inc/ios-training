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
    var response: WeatherResponse!
    func getWeather(completion: @escaping (Result<WeatherResponse, WeatherError>) -> ()) {
        completion(.success(response!))
    }
    
    func generateAPIErrorMessage(error: WeatherError) -> String {
        return ""
    }
}
