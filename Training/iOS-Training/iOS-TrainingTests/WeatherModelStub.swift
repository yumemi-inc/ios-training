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
    
    func getWeather(completionHandler: WeatherCompletionHandler) {
        guard let completionHandler = completionHandler else {
            fatalError("completionHandler is nil.")
        }
        completionHandler(.success(response))
    }
    
    func generateAPIErrorMessage(error: WeatherError) -> String {
        return ""
    }
}
