//
//  ViewController.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/03/30.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    var weatherModel: WeatherModel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapReload(_ sender: Any) {
        loadWeather()
    }
    
    func loadWeather() {
        let request = Request(area: "tokyo", date: Date())
        do {
            let response = try self.weatherModel.fetchWeather(request)
            self.weatherImageView.set(weather: response.weather)
            self.minTempLabel.text = String(response.minTemp)
            self.maxTempLabel.text = String(response.maxTemp)
        }
        catch {
            let message: String
            switch error {
            case let error as WeatherModelError where error ~= WeatherModelError.jsonEncodeError:
                message = "Jsonエンコードに失敗しました。"
            case let error as WeatherModelError where error ~= WeatherModelError.jsonDecodeError:
                message = "Jsonデコードに失敗しました。"
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

private extension UIImageView {
    func set(weather: Weather) {
        switch weather {
        case .sunny:
            self.image = R.image.sunny()
            self.tintColor = R.color.red()
        case .cloudy:
            self.image = R.image.cloudy()
            self.tintColor = R.color.gray()
        case .rainy:
            self.image = R.image.rainy()
            self.tintColor = R.color.blue()
        }
    }
}
