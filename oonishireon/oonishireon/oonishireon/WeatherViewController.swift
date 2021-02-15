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
        } catch {
            present(.alert(title: "エラー", message: "エラーが発生しました。"))
        }
    }
}
