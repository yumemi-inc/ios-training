//
//  WeatherViewModel.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

protocol WeatherModelProtocol {
    var presenter: WeatherModelOutput! { get set }
}

protocol WeatherModelOutput: class {
    
}

final class WeatherModel: WeatherModelProtocol {
    weak var presenter: WeatherModelOutput!
}

