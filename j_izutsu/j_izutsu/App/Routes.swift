//
//  Routes.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import UIKit

struct Routes {
    static func decideRootViewController() -> UIViewController {
        return WeatherViewBuilder.create()
    }
}

