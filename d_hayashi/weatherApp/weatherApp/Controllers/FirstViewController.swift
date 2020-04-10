//
//  FirstViewController.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/06.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        let weatherViewStoryboard: UIStoryboard = UIStoryboard(name: "WeatherView", bundle: nil)
        let weatherViewController: UIViewController = weatherViewStoryboard.instantiateViewController(withIdentifier: "WeatherViewController")
        self.present(weatherViewController, animated: true, completion: nil)
    }

}
