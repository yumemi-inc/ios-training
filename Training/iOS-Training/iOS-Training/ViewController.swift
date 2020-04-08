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
            switch error {
            case YumemiWeatherError.invalidParameterError:
                debugPrint("API Error: invalidParameterError")
            case YumemiWeatherError.jsonDecodeError:
                debugPrint("API Error: jsonDecodeError")
            case YumemiWeatherError.unknownError:
                debugPrint("API Error: unknownError")
            }
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
}

