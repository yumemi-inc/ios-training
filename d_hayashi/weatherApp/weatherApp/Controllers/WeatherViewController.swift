//
//  ViewController.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/02.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    private let inputString = "{ \"area\": \"tokyo\", \"date\": \"2020-04-01T12:00:00+09:00\" }"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            try print(YumemiWeather.fetchWeather(inputString))
        } catch {
            print("error")
        }
    }


}

