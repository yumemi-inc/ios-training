//
//  WeatherFetcher.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/17.
//

import UIKit
import YumemiWeather

struct WeatherFetcher {
    static func fetchJsonDictionary() throws -> [String: Any]? {
        let jsonString = #"{"area": "tokyo","date": "2020-04-01T12:00:00+09:00"}"#
        let fetchedWeather = try YumemiWeather.fetchWeather(jsonString)
        let jsonData =  fetchedWeather.data(using: .utf8)!
        let fetchedResultDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
        return fetchedResultDictionary
    }
}
