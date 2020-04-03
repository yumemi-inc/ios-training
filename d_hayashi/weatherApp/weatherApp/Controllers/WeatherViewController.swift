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
    private var inputJsonString = #"{ "area": "tokyo", "date": "2020-04-01T12:00:00+09:00" }"#
    private var weatherImageName = "sunny"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func tapReload(_ sender: Any) {
        
        let inputString = InputJSON(area: "tokyo", date: Date())

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let inputData = try encoder.encode(inputString)
            inputJsonString = String(data: inputData, encoding: .utf8)!
        } catch {
            print("encoding error")
        }
        
        do {
            let result: String = try YumemiWeather.fetchWeather(inputJsonString)
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
                weatherImageView.tintColor = .sunny
            case "rainy":
                weatherImageView.tintColor = .rainy
            case "cloudy":
                weatherImageView.tintColor = .gray
            default:
                weatherImageName = "sunny"
            }
            weatherImageView.image = UIImage(named: response.weather)?.withRenderingMode(.alwaysTemplate)

        } catch let weatherError as YumemiWeatherError {
            var errorTitleString = "unknown error"
            let errorMessageString = "エラーが発生しました"
            switch weatherError {
            case .invalidParameterError:
                errorTitleString = "invalid parameter error"
            case .jsonDecodeError:
                errorTitleString = "JSON decode error"
            case .unknownError:
                errorTitleString = "unknown error"
            }
            let errorAlertController: UIAlertController = UIAlertController(title: errorTitleString, message: errorMessageString, preferredStyle: .alert)
            errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(errorAlertController, animated: true)
        } catch {
            print("unextected")
        }
    }
}
