//
//  WeatherViewBuilder.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

struct WeatherViewBuilder {
    static func create() -> UIViewController {
        guard let weatherViewController = WeatherViewController.loadFromStoryboard() as? WeatherViewController else {
            fatalError()
        }
        let model = WeatherModel()
        let presenter = WeatherViewPresenter(model: model)
        weatherViewController.inject(with: presenter)
        return weatherViewController
    }
}
