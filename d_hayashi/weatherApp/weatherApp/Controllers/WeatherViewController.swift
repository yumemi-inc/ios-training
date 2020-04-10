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

    var weatherModel: WeatherModel = WeatherModelImpl()

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        weatherModel.delegate = self
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.contactWeatherAPI), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    // MARK: - IBAction
    @IBAction func tapReload(_ sender: Any) {

        self.contactWeatherAPI()
    }

    @IBAction func tapClose(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    // MARK: Contact to weather API
    @objc private func contactWeatherAPI() {

        let area = "tokyo"
        weatherModel.getWeather(area)
    }
}

// MARK: - delegate methods
extension WeatherViewController: WeatheModelDelegate {

    // MARK: Update View
    func weatherViewUpdate(_ weatherInfo: WeatherResponse) {

        minTempLabel.text = String(weatherInfo.minTemp) + " ˚C"
        maxTempLabel.text = String(weatherInfo.maxTemp) + " ˚C"

        let weather = weatherInfo.weather

        weatherImageView.tintColor = weather.color
        weatherImageView.image = weather.image.withRenderingMode(.alwaysTemplate)
    }

    // MARK: Show Error Alert
    func showErrorAlert(_ error: WeatherAppError) {

        let errorMessageString = "エラーが発生しました"
        let errorAlertController = UIAlertController(title: error.errorDescription, message: errorMessageString, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlertController, animated: true)
    }
}
