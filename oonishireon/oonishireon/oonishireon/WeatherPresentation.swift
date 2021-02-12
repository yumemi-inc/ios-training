//
//  PresentWeather.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/12.
//

import UIKit

struct WeatherPresentation {
    var image: UIImage?
    var tintColor: UIColor
    var tintedImage: UIImage? { image?.withTintColor(tintColor) }
    private static func nameAndColor(for weatherString: String) -> (imageName: String, tintColor: UIColor)? {
        {
            switch weatherString {
            case "sunny":  return ("sun", .red)
            case "rainy":  return ("umbrella", .blue)
            case "cloudy": return ("cloud", .gray)
            default:       return .none
            }
        }()
    }
    init?(weatherString: String) {
        guard let attributes = Self.nameAndColor(for: weatherString) else { return nil }
        image = UIImage(named: attributes.imageName)
        tintColor = attributes.tintColor
    }
}

