//
//  ViewController.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/02.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    // MARK: - Property
    private let inputString = "{ \"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }"
    private var weatherImageName = "sunny"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func tapReload(_ sender: Any) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        do {
            let result: String = try YumemiWeather.fetchWeather(inputString)
            guard let data = result.data(using: .utf8) else {
                // TODO: エラーハンドリング
                return
            }
            let response: WeatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            minTempLabel.text = String(response.minTemp) + " ˚C"
            maxTempLabel.text = String(response.maxTemp) + " ˚C"
            print(response.date)
            
            // TODO: 債務の切り分け (画像の変更は View に分ける)
            switch response.weather {
            case "sunny":
                weatherImageName = "sunny"
                weatherImageView.tintColor = .sunny
            case "rainy":
                weatherImageName = "rainy"
                weatherImageView.tintColor = .rainy
            case "cloudy":
                weatherImageName = "cloudy"
                weatherImageView.tintColor = .gray
            default:
                weatherImageName = "sunny"
            }
            weatherImageView.image = UIImage(named: weatherImageName)?.withRenderingMode(.alwaysTemplate)
        } catch let weatherError as YumemiWeatherError {
            let errorAlertController: UIAlertController = UIAlertController(title: "Error", message: "エラーが発生しました", preferredStyle: .alert)
            errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(errorAlertController, animated: true)
            switch weatherError {
            case .invalidParameterError:
                print("invalidParameter")
            case .jsonDecodeError:
                print("jsonDecode")
            case .unknownError:
                print("unknown")
            }
        } catch {
            print("unextected")
        }
    }
    
}

