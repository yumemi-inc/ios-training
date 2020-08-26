//
//  WeatherViewPresenter.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

protocol WeatherViewPresenterProtocol {
    var view: WeatherViewPresenterOutput! { get set }
    
    func didTapReloadButton()
    func didTapCloseButton()
}

protocol WeatherViewPresenterOutput: class {
    func setMaxTemp(_ temp: Int)
    func setMinTemp(_ temp: Int)
    func setSunnyImage(imageName: String)
    func setCloudyImage(imageName: String)
    func setRainyImage(imageName: String)
    
    func dismissVC()
}

final class WeatherViewPresenter: WeatherViewPresenterProtocol, WeatherModelOutput {
    weak var view: WeatherViewPresenterOutput!
    private var model: WeatherModelProtocol
    
    init(model: WeatherModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didTapReloadButton() {
        self.model.fetchWeather()
    }
    
    func didTapCloseButton() {
        self.view.dismissVC()
    }
    
    func successFetchWeather(response: WeatherResponse) {
        self.view.setMaxTemp(response.maxTemp)
        self.view.setMinTemp(response.minTemp)
        
        switch response.weather {
        case .sunny:
            self.view.setSunnyImage(imageName: response.weather.rawValue)
        case .cloudy:
            self.view.setCloudyImage(imageName: response.weather.rawValue)
        case .rainy:
            self.view.setRainyImage(imageName: response.weather.rawValue)
        }
    }
}

