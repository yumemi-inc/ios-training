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
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapReloadButton(_ sender: Any) {
        
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        
    }
    
    func inject(with presenter: WeatherViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension WeatherViewController: WeatherViewPresenterOutput {
    
}


