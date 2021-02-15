

//
//  ViewController.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/09.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak private var weatherImageView: UIImageView!
    private enum Weather: String {
        case sunny
        case rainy
        case cloudy
        var imageName: String {
            switch self {
            case .sunny:
                return "sun"
            case .rainy:
                return "umbrella"
            case .cloudy:
                return "cloud"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        let fetchedWeather = YumemiWeather.fetchWeather()
        guard let weather = Weather(rawValue: fetchedWeather) else { return }
        switch weather {
        case .sunny:
            guard let image = UIImage(named: Weather.sunny.imageName) else { return }
            weatherImageView.image = image.withTintColor(.red)
        case .rainy:
            guard let image = UIImage(named: Weather.rainy.imageName) else { return }
            weatherImageView.image = image.withTintColor(.blue)
        case .cloudy:
            guard let image = UIImage(named: Weather.cloudy.imageName) else { return }
            weatherImageView.image = image.withTintColor(.gray)
        }
    }
}



