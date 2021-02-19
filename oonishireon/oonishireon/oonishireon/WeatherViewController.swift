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
            let fetchedWeatherInformation = try WeatherFetcher.fetchWeatherInformation()
            let weatherPresentation = WeatherPresentation(weatherInformation: fetchedWeatherInformation)
            weatherImageView.image = weatherPresentation?.tintedImage
            minTemperatureLabel.text = weatherPresentation?.minTemperature
            maxTemperatureLabel.text = weatherPresentation?.maxTemperature
            
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
