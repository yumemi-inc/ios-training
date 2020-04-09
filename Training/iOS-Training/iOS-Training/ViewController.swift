//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherAPI = WeatherAPI()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reload(_ sender: Any) {
        switch weatherAPI.getWeather() {
        case .success(let weather):
            setWeatherImage(weather: weather)
        case .failure(let error):
            let errorMessage = weatherAPI.generateAPIErrorMessage(error: error)
            showAlert(title: "APIError", message: errorMessage)
        }
    }
    
    func setWeatherImage(weather: String) -> Void {
        switch weatherAPI.getWeatherColor(weather: weather) {
        case .success(let color):
            weatherImageView.image = UIImage(named: weather)?.withRenderingMode(.alwaysTemplate)
            weatherImageView.tintColor = color
        case .failure(let error):
            let errorMessage = weatherAPI.generateColorErrorMessage(error: error)
            showAlert(title: "ColorError", message: errorMessage)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

