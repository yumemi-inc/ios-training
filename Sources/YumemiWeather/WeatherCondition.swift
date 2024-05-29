//
//  WeatherCondition.swift
//

enum WeatherCondition: String, CaseIterable {
    case sunny
    case cloudy
    case rainy
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

