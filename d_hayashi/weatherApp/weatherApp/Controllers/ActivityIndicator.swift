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

    func setActivityIndicatorProperty() {

        activityIndicator.color = .gray
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)

        // MARK: - AutoLayout Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}
