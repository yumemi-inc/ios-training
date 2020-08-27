//
//  WeatherViewModel.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation

protocol WeatherModelProtocol {
    var presenter: WeatherModelOutput! { get set }
    
    func fetchWeather()
}

protocol WeatherModelOutput: class {
    func successFetchWeather(response: WeatherResponse)
    func errorFetchWeather(error: WeatherAPIError)
}

final class WeatherModel: WeatherModelProtocol {
    weak var presenter: WeatherModelOutput!
    private let weatherAPI = WeatherAPI()
    
    func fetchWeather() {
        self.weatherAPI.fetchWeather(area: "tokyo") { result in
            print(result)
            switch result {
            case let .success(response):
                self.presenter.successFetchWeather(response: response)
            case let .failure(error):
                self.presenter.errorFetchWeather(error: error)
            }
            
        }
    }
}
