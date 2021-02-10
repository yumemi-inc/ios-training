

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
        enum Image: String {
            case sun
            case umbrella
            case cloud
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
            guard let image = UIImage(named: Weather.Image.sun.rawValue) else { return }
            weatherImageView.image = image.withTintColor(.red)
        case .rainy:
            guard let image = UIImage(named: Weather.Image.umbrella.rawValue) else { return }
            weatherImageView.image = image.withTintColor(.blue)
        case .cloudy:
            guard let image = UIImage(named: Weather.Image.cloud.rawValue) else { return }
            weatherImageView.image = image.withTintColor(.gray)
        }
    }
    
    


}



