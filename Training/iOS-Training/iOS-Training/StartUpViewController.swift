//
//  ViewControllerFirst.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/14.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toWeather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeather" {
            let weatherViewController = segue.destination as! WeatherViewController
            weatherViewController.weatherModel = WeatherModelImpl()
        }
    }
}
