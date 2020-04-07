//
//  GetWeatherResourceName.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/07.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation

final class GetWeatherResourceName {

    func getColorName(_ weather: String) throws -> String {

        switch weather {

        case "sunny":
            return "sunny"

        case "cloudy":
            return "cloudy"

        case "rainy":
            return "rainy"

        default:
            throw WeatherAppError.unknownAppError
        }
    }

    func getImageName(_ weather: String) throws -> String {

        switch weather {

        case "sunny":
            return "sunny"

        case "cloudy":
            return "cloudy"

        case "rainy":
            return "rainy"

        default:
            throw WeatherAppError.unknownAppError
        }
    }
}
