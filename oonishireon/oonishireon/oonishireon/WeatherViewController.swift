//
//  WeatherViewController.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/09.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var weatherImageView: UIImageView!
    @IBOutlet weak private var minTemperatureLabel: UILabel!
    @IBOutlet weak private var maxTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        do {
            let jsonString = "{\"area\": \"tokyo\",\"date\": \"2020-04-01T12:00:00+09:00\"}"
            let fetchedWeather = try YumemiWeather.fetchWeather(jsonString)
            let jsonData =  fetchedWeather.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String: Any]
            weatherImageView.image = WeatherPresentation(weatherString: json["weather"] as! String)?.tintedImage
            if let jsonMinTemp = json["min_temp"], let jsonMaxTemp = json["max_temp"] {
                let jsonMinTempString = String(describing: jsonMinTemp)
                minTemperatureLabel.text = jsonMinTempString
                let jsonMaxTempString = String(describing: jsonMaxTemp)
                maxTemperatureLabel.text = jsonMaxTempString
            }
            
        } catch YumemiWeatherError.invalidParameterError {
            present(.createAlert(title: "エラー", message: "無効なパラメータが発生しました。"))
            
        } catch YumemiWeatherError.jsonDecodeError {
            present(.createAlert(title: "エラー", message: "Jsonの読み込みに失敗しました。"))
            
        } catch YumemiWeatherError.unknownError {
            present(.createAlert(title: "エラー", message: "不明なエラーが発生しました。"))
            
        } catch {
            present(.createAlert(title: "エラー", message: "予期しないエラーが発生しました。"))
            assertionFailure("YumemiWeatherErrorでないエラーが発生しました。")
        }
    }
}
