//
//  ViewController.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/03/30.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    struct JsonDecodeError: Error {
    }
    
    enum Weather: String {
        case sunny
        case cloudy
        case rainy
    }

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTouchReload(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let requestJson = """
        {
            "area": "tokyo",
            "date": "\(dateFormatter.string(from: Date()))"
        }
        """
        
        do {
            let responseJson = try YumemiWeather.fetchWeather(requestJson)
            guard let responseData = responseJson.data(using: .utf8) else {
                throw JsonDecodeError()
            }
            
            let responseJsonObject = try JSONSerialization.jsonObject(with: responseData, options: [])
            guard let responseDictionary = responseJsonObject as? [String: Any] else {
                throw JsonDecodeError()
            }
            
            guard let weatherString = responseDictionary["weather"] as? String,
                let weather = Weather(rawValue: weatherString) else {
                throw JsonDecodeError()
            }
            guard let minTemp = responseDictionary["min_temp"] as? Int else {
                throw JsonDecodeError()
            }
            guard let maxTemp = responseDictionary["max_temp"] as? Int else {
                throw JsonDecodeError()
            }
            
            switch weather {
            case .sunny:
                self.weatherImageView.image = R.image.sunny()
                self.weatherImageView.tintColor = R.color.red()
            case .cloudy:
                self.weatherImageView.image = R.image.cloudy()
                self.weatherImageView.tintColor = R.color.gray()
            case .rainy:
                self.weatherImageView.image = R.image.rainy()
                self.weatherImageView.tintColor = R.color.blue()
            }
            self.minTempLabel.text = String(minTemp)
            self.maxTempLabel.text = String(maxTemp)
        }
        catch {
            let message: String
            switch error {
            case is JsonDecodeError:
                message = "天気予報が読み取れませんでした。"
            case let error as YumemiWeatherError where error ~= YumemiWeatherError.unknownError:
                message = "エラーが発生しました。"
            case let error as YumemiWeatherError where error ~= YumemiWeatherError.invalidParameterError:
                message = "パラメータが不正です。"
            default:
                message = "エラーが発生しました。"
            }
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

