//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

enum Weather {
    case sunny
    case cloudy
    case rainy
    
    func getColor() -> UIColor {
        switch self {
        case .sunny:
            return UIColor.red
            
        case .cloudy:
            return UIColor.gray
            
        case .rainy:
            return UIColor.blue
        }
    }
}

enum WeatherError: Error {
    case notExistsError
}

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
            do {
                try setWeatherImage(weather: weather)
            } catch {
                showAlert(title: "WeatherError", message: "notExistsError")
            }
        case .failure(let error):
            let errorMessage = weatherAPI.generateAPIErrorMessage(error: error)
            showAlert(title: "APIError", message: errorMessage)
        }
    }
    
    func setWeatherImage(weather: String) throws -> Void {
        if !weatherAPI.isInWeatherTypes(weather: weather) {
            throw WeatherError.notExistsError
        }
        
        var color: UIColor
        switch weather {
        case "sunny":
            color = Weather.sunny.getColor()
            
        case "cloudy":
            color = Weather.cloudy.getColor()
            
        case "rainy":
            color = Weather.rainy.getColor()
            
        default:
            throw WeatherError.notExistsError
        }
        
        weatherImageView.image = UIImage(named: weather)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

