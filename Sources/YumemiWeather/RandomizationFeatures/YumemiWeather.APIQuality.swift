//
//  YumemiWeather.APIQuality.swift
//
//  
//  Created by Tomohiro Kumagai on 2024/05/02
//  
//

extension YumemiWeather {
    
    /// API の品質を表現します。
    enum APIQuality {
        case sometimesFails(probability: Double)
        case alwaysFails
        case neverFails
    }
}

extension YumemiWeather {
    
    /// API の想定品質です。
    static var apiQuality: APIQuality = .sometimesFails(probability: 0.25)
    
    static func whetherHit(with probability: Double) -> Bool {
        return (0 ..< probability).contains(.random(in: 0 ..< 1))
    }
    
    /// この場所に不安定要素を埋め込みます。
    ///
    /// 不安定さの度合いは `apiQuality` に依存します。
    /// - Throws: YumemiError ここで失敗が生成されると YumemiWeatherError.unknownError が送出されます。
    static func introduceInstability() throws {
        
        switch apiQuality {

        case .neverFails:
            return

        case .sometimesFails(let probability) where !whetherHit(with: probability):
            return

        case .sometimesFails, .alwaysFails:
            throw YumemiWeatherError.unknownError
        }
    }
    
    /// この場所に不安定要素を埋め込みます。
    ///
    /// 不安定さの度合いは `apiQuality` に依存します。
    /// - Throws: YumemiError ここで失敗が生成されると YumemiWeatherError.unknownError が送出されます。
    func introduceInstability() throws {
        try Self.introduceInstability()
    }
}
