//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let weatherAPI = WeatherAPI()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.updateWeather), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @IBAction func reload(_ sender: Any) {
        self.updateWeather()
    }
    
    func setWeatherImage(weather: Weather) -> Void {
        let color: UIColor
        switch weather {
        case .sunny:
            color = UIColor.red
            
        case .cloudy:
            color = UIColor.gray
            
        case .rainy:
            color = UIColor.blue
        }
        
        weatherImageView.image = UIImage(named: weather.rawValue)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissSelfViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateWeather() {
        switch weatherAPI.getWeather() {
        case .success(let response):
            minTemperatureLabel.text = String(response.minTemp)
            maxTemperatureLabel.text = String(response.maxTemp)
            setWeatherImage(weather: response.weather)
        case .failure(let error):
            let errorMessage = weatherAPI.generateAPIErrorMessage(error: error)
            showAlert(title: "APIError", message: errorMessage)
        }
    }
}

