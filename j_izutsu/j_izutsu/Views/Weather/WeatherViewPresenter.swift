//
//  WeatherViewPresenter.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

protocol WeatherViewPresenterProtocol {
    var view: WeatherViewPresenterOutput! { get set }
}

protocol WeatherViewPresenterOutput: class {
    
}

final class WeatherViewPresenter: WeatherViewPresenterProtocol, WeatherModelOutput {
    weak var view: WeatherViewPresenterOutput!
    private var model: WeatherModelProtocol
    
    init(model: WeatherModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
}

