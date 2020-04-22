//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    let weatherModel: WeatherModel
    let activityIndicatorView = UIActivityIndicatorView()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init?(coder: NSCoder, weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.updateWeatherView), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .purple
        view.addSubview(activityIndicatorView)
    }
    
    @IBAction func reload(_ sender: Any) {
        self.updateWeatherView()
    }
    
    func setWeatherImage(weather: Weather) -> Void {
        let color: UIColor
        switch weather {
        case .sunny:
            color = UIColor.red
            
        case .cloudy:
            color = UIColor.gray
            
        case .rainy:
            color = UIColor.blue
        }
        
        weatherImageView.image = UIImage(named: weather.rawValue)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissSelfViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateWeatherView() {
        activityIndicatorView.startAnimating()
        DispatchQueue.main.async {
            let result = self.weatherModel.getWeather()
            self.activityIndicatorView.stopAnimating()
            switch result {
            case .success(let response):
                self.minTemperatureLabel.text = String(response.minTemp)
                self.maxTemperatureLabel.text = String(response.maxTemp)
                self.setWeatherImage(weather: response.weather)
            case .failure(let error):
                let errorMessage = self.weatherModel.generateAPIErrorMessage(error: error)
                self.showAlert(title: "APIError", message: errorMessage)
            }
        }
    }
}
