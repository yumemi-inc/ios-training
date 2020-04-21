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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = storyboard.instantiateViewController(identifier: "WeatherViewController", creator: { (coder) -> WeatherViewController? in
            WeatherViewController.init(coder: coder, weatherModel: WeatherModelImpl())
        })
        weatherViewController.modalPresentationStyle = .fullScreen
        self.present(weatherViewController, animated: true, completion: nil)
    }
}
