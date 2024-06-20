//
//  RandomResponse.swift
//
//
//  Created by Tomohiro Kumagai on 2024/06/20.
//

import Foundation

extension YumemiWeather {
    
    /// 引数の値でResponse構造体を作成する。引数がnilの場合はランダムに値を作成する。
    /// - Parameters:
    ///   - weatherCondition: 天気状況を表すenum
    ///   - maxTemperature: 最高気温
    ///   - minTemperature: 最低気温
    ///   - date: 日付
    /// - Returns: Response構造体
    static func makeRandomResponse(
        weatherCondition: WeatherCondition? = nil,
        maxTemperature: Int? = nil,
        minTemperature: Int? = nil,
        date: Date? = nil
    ) -> Response {
        return makeRandomResponse(using: &ControllableGenerator.shared, weatherCondition: weatherCondition, maxTemperature: maxTemperature, minTemperature: minTemperature)
    }
    
    /// 引数の値でResponse構造体を作成する。引数がnilの場合はランダムに値を作成する。
    /// - Parameters:
    ///   - weatherCondition: 天気状況を表すenum
    ///   - maxTemperature: 最高気温
    ///   - minTemperature: 最低気温
    ///   - date: 日付
    /// - Returns: Response構造体
    static func makeRandomResponse(
        using generator: inout some RandomNumberGenerator,
        weatherCondition: WeatherCondition? = nil,
        maxTemperature: Int? = nil,
        minTemperature: Int? = nil,
        date: Date? = nil
    ) -> Response {
        let weatherCondition = weatherCondition ?? .random(using: &generator)
        let maxTemperature = maxTemperature ?? .random(in: 10...40, using: &generator)
        let minTemperature = minTemperature ?? .random(in: -40..<maxTemperature, using: &generator)
        let date = date ?? Date()
        
        return Response(
            weatherCondition: weatherCondition.rawValue,
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            date: date
        )
    }
}

extension WeatherCondition {
    
    /// 天候をランダムで取得します。
    /// - Returns: なにかしらの天候を返します。
    static func random() -> Self {
        random(using: &ControllableGenerator.shared)
    }
    
    /// 天候をランダムで取得します。
    /// - Parameter generator: ランダムで取得するのに使う乱数生成期です。
    /// - Returns: なにかしらの天候を返します。
    static func random(using generator: inout some RandomNumberGenerator) -> Self {
        allCases.randomElement(using: &generator)!
    }
}
