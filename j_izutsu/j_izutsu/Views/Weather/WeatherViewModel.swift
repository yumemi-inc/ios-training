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
    func successFetchWeather(responce: WeatherResponse)
}

final class WeatherModel: WeatherModelProtocol {
    weak var presenter: WeatherModelOutput!
    private let weatherAPI = WeatherAPI()
    
    func fetchWeather() {
        let result = self.weatherAPI.fetchWeather(area: "tokyo")
        
        switch result {
        case let .success(responce):
            self.presenter.successFetchWeather(responce: responce)
        case let .failure(error):
            print(error)
        }
    }
}

