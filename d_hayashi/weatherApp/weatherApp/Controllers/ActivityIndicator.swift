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

    func commandActivityIndicator() {

        activityIndicator.color = .gray
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = view.center
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true

        self.view.addSubview(activityIndicator)
    }
}
