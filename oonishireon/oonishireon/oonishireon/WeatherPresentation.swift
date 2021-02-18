//
//  WeatherPresentation.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/12.
//

import UIKit

struct WeatherPresentation {
    let image: UIImage?
    let tintColor: UIColor
    var tintedImage: UIImage? { image?.withTintColor(tintColor) }
    let maxTemperature: String
    let minTemperature: String
    
    private static func nameAndColor(for weatherString: String) -> (imageName: String, tintColor: UIColor)? {
        switch weatherString {
        case "sunny":  return ("sun", .red)
        case "rainy":  return ("umbrella", .blue)
        case "cloudy": return ("cloud", .gray)
        default:       return .none
        }
    }
    
    init?(weatherDictionary: [String: Any]) {
        guard let attributes = Self.nameAndColor(for: weatherDictionary["weather"] as! String),
              let maxTemp = weatherDictionary["max_temp"],
              let minTemp = weatherDictionary["min_temp"] else { return nil }
        image = UIImage(named: attributes.imageName)
        tintColor = attributes.tintColor
        maxTemperature = String(describing: maxTemp)
        minTemperature = String(describing: minTemp)
    }
}

