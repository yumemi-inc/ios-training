//
//  HomeViewModel.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/26.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation

protocol HomeModelProtocol {
    var presenter: HomeModelOutput! { get set }
}

protocol HomeModelOutput: class {
    
}

final class HomeModel: HomeModelProtocol {
    weak var presenter: HomeModelOutput!
    
   
}

