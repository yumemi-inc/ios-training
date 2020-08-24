//
//  WeatherViewController.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    private var presenter: WeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func inject(with presenter: WeatherViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension WeatherViewController: WeatherViewPresenterOutput {
    
}


