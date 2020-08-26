//
//  HomeViewPresenter.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

protocol HomeViewPresenterProtocol {
    var view: HomeViewPresenterOutput! { get set }
    
    func didViewDidAppear()
}

protocol HomeViewPresenterOutput: class {
    func showWeatherViewController()
}

final class HomeViewPresenter: HomeViewPresenterProtocol, HomeModelOutput {
    weak var view: HomeViewPresenterOutput!
    private var model: HomeModelProtocol
    
    init(model: HomeModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func didViewDidAppear() {
        self.view.showWeatherViewController()
    }
    
}
