//
//  HomeViewBuilder.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

struct HomeViewBuilder {
    static func create() -> UIViewController {
        guard let homeViewController = HomeViewController.loadFromStoryboard() as? HomeViewController else {
            fatalError()
        }
        let model = HomeModel()
        let presenter = HomeViewPresenter(model: model)
        homeViewController.inject(with: presenter)
        return homeViewController
    }
}

