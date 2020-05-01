//
//  ViewController.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/02.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherModelDelegate {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    var weatherModel: WeatherModel
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
        
        weatherModel.delegate = self
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.reload(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        setActivityIndicatorViewProperty()
    }
    
    @IBAction func reload(_ sender: Any) {
        activityIndicatorView.startAnimating()
        self.getWeather(completion: { [weak self] in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    func setWeatherImage(weather: Weather) -> Void {
        let color: UIColor
        switch weather {
        case .sunny:
            color = .red
            
        case .cloudy:
            color = .gray
            
        case .rainy:
            color = .blue
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
    
    func updateWeatherView(response: WeatherResponse) {
        minTemperatureLabel.text = String(response.minTemp)
        maxTemperatureLabel.text = String(response.maxTemp)
        setWeatherImage(weather: response.weather)
    }
    
    func getWeather(completion: @escaping() -> ()){
        self.weatherModel.getWeather { result in
            DispatchQueue.main.sync { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.updateWeatherView(response: response)
                case .failure(let error):
                    let errorMessage = self.weatherModel.generateAPIErrorMessage(error: error)
                    self.showAlert(title: "APIError", message: errorMessage)
                }
                completion()
            }
        }
    }
    
    func setActivityIndicatorViewProperty() {
        activityIndicatorView.color = .white
        activityIndicatorView.backgroundColor =  UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    func didGetWeather(result: Result<WeatherResponse, WeatherError>) {
        switch result {
        case .success(let response):
            updateWeatherView(response: response)
        case .failure(let error):
            let errorMessage = self.weatherModel.generateAPIErrorMessage(error: error)
            self.showAlert(title: "APIError", message: errorMessage)
        }
    }
}
