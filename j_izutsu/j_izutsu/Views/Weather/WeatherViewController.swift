//
//  WeatherViewController.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    private var presenter: WeatherViewPresenterProtocol!
    private var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActivityIndicator()
        self.setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupActivityIndicator() {
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func viewWillEnterForeground(_ notification: Notification) {
        guard self.isViewLoaded else { return }
        
        self.presenter.didViewEnterForeground()
    }
    
    @IBAction func tapReloadButton(_ sender: Any) {
        self.presenter.didTapReloadButton()
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.presenter.didTapCloseButton()
    }
    
    func inject(with presenter: WeatherViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension WeatherViewController: WeatherViewPresenterOutput {
    func setMaxTemp(_ temp: Int) {
        DispatchQueue.main.async {
            self.maxTemperatureLabel.text = String(temp)
        }
    }
    
    func setMinTemp(_ temp: Int) {
        DispatchQueue.main.async {
            self.minTemperatureLabel.text = String(temp)
        }
    }
    
    func setSunnyImage(imageName: String) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self.weatherImageView.tintColor = .systemRed
        }
    }
    
    func setCloudyImage(imageName: String) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self.weatherImageView.tintColor = .systemGray
        }
    }
    
    func setRainyImage(imageName: String) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self.weatherImageView.tintColor = .systemBlue
        }
    }
    
    func disenabledReloadButton() {
        DispatchQueue.main.async { self.reloadButton.isEnabled = false }
    }
    
    func enabledReloadButton() {
        DispatchQueue.main.async { self.reloadButton.isEnabled = true }
    }
    
    func startActivityIndicator() {
        DispatchQueue.main.async { self.activityIndicator.startAnimating() }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}


