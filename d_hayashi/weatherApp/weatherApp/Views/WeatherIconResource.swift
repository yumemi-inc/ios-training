//
//  WeatherIconResource.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/08.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import UIKit

extension WeatherResponse.Weather {

    var color: UIColor {

        switch self {
            
        case .sunny: return UIColor(named: "sunny") ?? .red
        case .cloudy: return UIColor(named: "cloudy") ?? .gray
        case .rainy: return UIColor(named: "rainy") ?? .blue
        }
    }

    var image: UIImage {

        switch self {

        case .sunny: return #imageLiteral(resourceName: "sunny")
        case .cloudy: return #imageLiteral(resourceName: "cloudy")
        case .rainy: return #imageLiteral(resourceName: "rainy")
        }
    }
}
