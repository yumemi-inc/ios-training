//
//  HomeViewController.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    private var presenter: HomeViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.presenter.didViewDidAppear()
    }
    
    func inject(with presenter: HomeViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension HomeViewController: HomeViewPresenterOutput {
    func showWeatherViewController() {
        let weatherVC = WeatherViewBuilder.create()
        weatherVC.modalPresentationStyle = .fullScreen
        self.present(weatherVC, animated: true, completion: nil)
    }
}
