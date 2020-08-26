//
//  WeatherAPIStub.swift
//  j_izutsuTests
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation
import XCTest
@testable import j_izutsu

class WeatherAPIStub: WeatherAPIModel {
    var response: WeatherResponse?
    
    func setResponce(response: WeatherResponse) {
        self.response = response
    }
    
    func fetchWeather(area: String) -> Result<WeatherResponse, WeatherAPIError> {
        guard let response = response else { XCTFail(" set response ") }
        return .success(response)
    }
}
