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
        
    }
    
    func inject(with presenter: HomeViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension HomeViewController: HomeViewPresenterOutput {
    
}
