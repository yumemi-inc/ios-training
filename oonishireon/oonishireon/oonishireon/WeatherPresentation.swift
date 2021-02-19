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
    
    init?(weatherInformation: WeatherInformation) {
        guard let attributes = Self.nameAndColor(for: weatherInformation.weather) else { return nil }
        let maxTemp = weatherInformation.minTemp
        let minTemp = weatherInformation.maxTemp
        image = UIImage(named: attributes.imageName)
        tintColor = attributes.tintColor
        maxTemperature = String(describing: maxTemp)
        minTemperature = String(describing: minTemp)
    }
}

