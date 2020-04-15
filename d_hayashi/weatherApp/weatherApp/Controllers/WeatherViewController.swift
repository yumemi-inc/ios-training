//
//  ViewController.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/02.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!

    // MARK: - Property
    private var weatherModel: WeatherModel!
    let activityIndicator = UIActivityIndicatorView()
    let semaphore = DispatchSemaphore(value: 0)

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.

        weatherModel.delegate = self
        commandActivityIndicator()
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.contactWeatherAPI), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    // MARK: - generate ViewController and set WeatherModel
    static func generateViewController(model: WeatherModel) -> WeatherViewController {

        let weatherViewStoryboard: UIStoryboard = UIStoryboard(name: "WeatherView", bundle: nil)
        let weatherViewController: WeatherViewController = weatherViewStoryboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        weatherViewController.weatherModel = model

        return weatherViewController
    }

    // MARK: - IBAction
    @IBAction func tapReload(_ sender: Any) {

        contactWeatherAPI()
    }

    @IBAction func tapClose(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    // MARK: Contact to weather API
    @objc func contactWeatherAPI() {

        activityIndicator.startAnimating()

        let area = "tokyo"
        weatherModel.getWeather(area)
    }

    // MARK: Update View
    private func weatherViewUpdate(_ weatherInfo: WeatherResponse) {

        minTempLabel.text = String(weatherInfo.minTemp) + " ˚C"
        maxTempLabel.text = String(weatherInfo.maxTemp) + " ˚C"

        let weather = weatherInfo.weather

        weatherImageView.tintColor = weather.color
        weatherImageView.image = weather.image.withRenderingMode(.alwaysTemplate)
    }

    // MARK: Show Error Alert
    private func showErrorAlert(_ error: WeatherAppError) {

        let errorMessageString = "エラーが発生しました"
        let errorAlertController = UIAlertController(title: error.errorDescription, message: errorMessageString, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlertController, animated: true)
    }
}

// MARK: - delegate methods
extension WeatherViewController: WeatheModelDelegate {

    func didGetWeather(_ result: Result<WeatherResponse, WeatherAppError>) {

        activityIndicator.stopAnimating()
        
        switch result {
            
        case let .success(response):
            weatherViewUpdate(response)
            
        case let .failure(error):
            showErrorAlert(error)
        }
    }
}
