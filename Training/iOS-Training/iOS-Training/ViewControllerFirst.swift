//
//  ViewControllerFirst.swift
//  iOS-Training
//
//  Created by 酒井 桂哉 on 2020/04/14.
//  Copyright © 2020 tokizuoh. All rights reserved.
//

import UIKit

class ViewControllerFirst: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
}
