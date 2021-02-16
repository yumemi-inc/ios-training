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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        do {
            let fetchedWeather = try YumemiWeather.fetchWeather(at: "tokyo")
            weatherImageView.image = WeatherPresentation(weatherString: fetchedWeather)?.tintedImage
            
        } catch let error as YumemiWeatherError {
            switch error {
            
            case .invalidParameterError:
                present(.alert(title: "エラー", message: "無効なパラメータが発生しました。"))
                
            case .jsonDecodeError:
                present(.alert(title: "エラー", message: "Jsonの読み込みに失敗しました。"))
                
            case .unknownError:
                present(.alert(title: "エラー", message: "不明なエラーが発生しました。"))
            }
            
        } catch {
            present(.alert(title: "エラー", message: "予期しないエラーが発生しました。"))
            assertionFailure("YumemiWeatherErrorでないエラーが発生しました。")
        }
    }
}
