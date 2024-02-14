//
//  ViewController.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/03/30.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol WeatherModel {
    func fetchWeather(at area: String, date: Date, completion: @escaping (Result<Response, WeatherError>) -> Void)
}

protocol DisasterModel {
    func fetchDisaster(completion: ((String) -> Void)?)
}

class WeatherViewController: UIViewController {
    
    var weatherModel: WeatherModel!
    var disasterModel: DisasterModel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var disasterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [unowned self] notification in
            self.loadWeather(notification.object)
        }
    }
    
    deinit {
        print(#function)
    }
            
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadWeather(_ sender: Any?) {
        self.activityIndicator.startAnimating()
        weatherModel.fetchWeather(at: "tokyo", date: Date()) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.handleWeather(result: result)
            }
        }
        disasterModel.fetchDisaster { (disaster) in
            self.disasterLabel.text = disaster
        }
    }
    
    func handleWeather(result: Result<Response, WeatherError>) {
        switch result {
        case .success(let response):
            self.weatherImageView.set(weather: response.weather)
            self.minTempLabel.text = String(response.minTemp)
            self.maxTempLabel.text = String(response.maxTemp)
            
        case .failure(let error):
            let message: String
            switch error {
            case .jsonEncodeError:
                message = "JSONエンコードに失敗しました。"
            case .jsonDecodeError:
                message = "JSONデコードに失敗しました。"
            case .unknownError:
                message = "エラーが発生しました。"
            }
            
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true) {
                    print("Close ViewController by \(alertController)")
                }
            })
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
