//
//  YumemiWeatherList.swift
//
//
//  Created by 古宮 伸久 on 2022/04/04.
//

import Foundation

struct AreaRequest: Decodable {
    let areas: [String]
    let date: Date
}

struct AreaResponse: Codable {
    let area: Area
    let info: Response
}

public enum Area: String, CaseIterable, Codable {
    case Sapporo
    case Sendai
    case Niigata
    case Kanazawa
    case Tokyo
    case Nagoya
    case Osaka
    case Hiroshima
    case Kochi
    case Fukuoka
    case Kagoshima
    case Naha
}

public extension YumemiWeather {

    /// 擬似 天気予報一覧 API JSON ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "areas": ["Tokyo"],
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    /// 返された AreaResponse の JSON 文字列の例
    ///
    ///     [
    ///         {
    ///             "area": "Tokyo",
    ///             "info": {
    ///                 "max_temperature": 25,
    ///                 "date": "2020-04-01T12:00:00+09:00",
    ///                 "min_temperature": 7,
    ///                 "weather_condition": "cloudy"
    ///             }
    ///         }
    ///     ]
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: 返された AreaResponse の JSON 文字列
    static func fetchWeatherList(_ jsonString: String) throws -> String {
        guard let requestData = jsonString.data(using: .utf8),
              let request = try? decoder.decode(AreaRequest.self, from: requestData) else {
            throw YumemiWeatherError.invalidParameterError
        }

        if Int.random(in: 0...4) == 4 {
            throw YumemiWeatherError.unknownError
        }

        let areas = request.areas.isEmpty ? Area.allCases : request.areas.compactMap { Area(rawValue: $0) }
        let response = areas.map { area -> AreaResponse in
            var hasher = Hasher()
            hasher.combine(area)
            hasher.combine(request.date)
            return AreaResponse(area: area, info: makeRandomResponse(date: request.date, seed: hasher.finalize()))
        }
        let responseData = try encoder.encode(response)

        return String(data: responseData, encoding: .utf8)!
    }

    /// 擬似 天気予報一覧 API Sync ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "areas": ["Tokyo"],
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    /// 返された AreaResponse の JSON 文字列の例
    ///
    ///     [
    ///         {
    ///             "area": "Tokyo",
    ///             "info": {
    ///                 "max_temperature": 25,
    ///                 "date": "2020-04-01T12:00:00+09:00",
    ///                 "min_temperature": 7,
    ///                 "weather_condition": "cloudy"
    ///             }
    ///         }
    ///     ]
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: 返された AreaResponse の JSON 文字列
    static func syncFetchWeatherList(_ jsonString: String) throws -> String {
        Thread.sleep(forTimeInterval: apiDuration)
        return try self.fetchWeatherList(jsonString)
    }

    /// 擬似 天気予報一覧 API Callback ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "areas": ["Tokyo"],
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 成功に返された天気 Result の中に JSON 文字列の例：
    ///
    ///     [
    ///         {
    ///             "area": "Tokyo",
    ///             "info": {
    ///                 "max_temperature": 25,
    ///                 "date": "2020-04-01T12:00:00+09:00",
    ///                 "min_temperature": 7,
    ///                 "weather_condition": "cloudy"
    ///             }
    ///         }
    ///     ]
    ///
    /// また、YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameters:
    ///   - jsonString: 地域と日付を含む JSON 文字列
    ///   - completion: 完了コールバック
    static func fetchWeatherList(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + apiDuration) {
            do {
                let response = try fetchWeatherList(jsonString)
                completion(.success(response))
            }
            catch let error as YumemiWeatherError {
                completion(.failure(error))
            }
            catch {
                fatalError()
            }
        }
    }

    /// 擬似 天気予報一覧API Async ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "areas": ["Tokyo"],
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    /// 返された AreaResponse の JSON 文字列の例
    ///
    ///     [
    ///         {
    ///             "area": "Tokyo",
    ///             "info": {
    ///                 "max_temperature": 25,
    ///                 "date": "2020-04-01T12:00:00+09:00",
    ///                 "min_temperature": 7,
    ///                 "weather_condition": "cloudy"
    ///             }
    ///         }
    ///     ]
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: 返された AreaResponse の JSON 文字列
    @available(iOS 13, macOS 10.15, *)
    static func asyncFetchWeatherList(_ jsonString: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            fetchWeatherList(jsonString) { result in
                continuation.resume(with: result)
            }
        }
    }
}
