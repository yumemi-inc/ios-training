//
//  ActivityIndicator.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/13.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import UIKit

extension WeatherViewController {

    func generateActivityIndicator() {

        activityIndicator.backgroundColor = .black
        activityIndicator.color = .white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = view.center
        activityIndicator.style = .large

        self.view.addSubview(activityIndicator)
    }

    func startActivityIndicator() {

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

    }
    func stopActivityIndicator() {

        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = true
    }
}
