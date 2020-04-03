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
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result: String = try YumemiWeather.fetchWeather(inputString)
            guard let data = result.data(using: .utf8) else {
                // TODO: エラーハンドリング
                return
            }
            let response: WeatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            print(response.maxTemp)
        } catch {
            print("error")
        }
    }


}

