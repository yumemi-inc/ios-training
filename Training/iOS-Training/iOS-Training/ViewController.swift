//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    let weatherAPI = WeatherAPI()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchDownReloadButton(_ sender: Any) {
        switch weatherAPI.getWeather() {
        case .success(let weather):
            do {
                try setWeatherImage(imageName: weather)
            } catch {
                debugPrint("unexpectedError")
            }
        case .failure(let error):
            showAlert(error: error)
        }
    }
    
    func setWeatherImage(imageName: String) throws -> Void {
        weatherImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        
        switch imageName {
        case "sunny":
            weatherImageView.tintColor = UIColor.red
        case "cloudy":
            weatherImageView.tintColor = UIColor.gray
        case "rainy":
            weatherImageView.tintColor = UIColor.blue
        default:
            throw NSError(domain: "unexpectedError", code: -1, userInfo: nil)
        }
    }
    
    func showAlert(error: YumemiWeatherError) {
        var alertMessage: String
        switch error {
        case YumemiWeatherError.invalidParameterError:
            alertMessage = "invalidParameterError"
        case YumemiWeatherError.jsonDecodeError:
            alertMessage = "jsonDecodeError"
        case YumemiWeatherError.unknownError:
            alertMessage = "unknownError"
        }
        
        let alert = UIAlertController(title:"API Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

