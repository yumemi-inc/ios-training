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

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - IBAction
    @IBAction func tapReload(_ sender: Any) {

        self.contactWeatherAPI("tokyo")
    }

    // MARK: Contact to weather API
    private func contactWeatherAPI(_ area: String) {

        let weatherResult = WeatherAPIOperator().getWeather(area)

        switch weatherResult {

        case let .success(response):
            weatherViewUpdate(response)
            print(response.date)

        case let .failure(error):
            showErrorAlert(error)
        }
    }

    // MARK: Update View
    private func weatherViewUpdate(_ weatherInfo: WeatherResponse) {

        minTempLabel.text = String(weatherInfo.minTemp) + " ˚C"
        maxTempLabel.text = String(weatherInfo.maxTemp) + " ˚C"

        guard let weather = ResourceWeatherType(rawValue: weatherInfo.weather) else {

            self.showErrorAlert(.resourceNameError)
            return
        }

        weatherImageView.tintColor = weather.color
        weatherImageView.image = weather.image.withRenderingMode(.alwaysTemplate)
    }

    // MARK: Show Error Alert
    private func showErrorAlert(_ error: WeatherAppError) {

        let errorMessageString = "エラーが発生しました"
        let errorAlertController: UIAlertController = UIAlertController(title: error.errorDescription, message: errorMessageString, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlertController, animated: true)
    }
}
