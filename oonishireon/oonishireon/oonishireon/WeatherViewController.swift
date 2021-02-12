

//
//  ViewController.swift
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
        let fetchedWeather = YumemiWeather.fetchWeather()
        weatherImageView.image = PresentWeather(weatherString: fetchedWeather)?.tintedImage
    }
}

