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
    
    /// 擬似 天気予報一覧API Json ver
    /// - Parameter jsonString: 地域と日付を含むJson文字列
    /// example:
    /// {
    ///   "areas": ["Tokyo"],
    ///   "date": "2020-04-01T12:00:00+09:00"
    /// }
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Returns: Json文字列
    /// example: [{area: Tokyo, info: {"max_temp":25,"date":"2020-04-01T12:00:00+09:00","min_temp":7,"weather":"cloudy"}}]
    static func fetchWeatherList(_ jsonString: String) throws -> String {
        guard let requestData = jsonString.data(using: .utf8),
              let request = try? decoder.decode(AreaRequest.self, from: requestData) else {
            throw YumemiWeatherError.invalidParameterError
        }

        if Int.random(in: 0...4) == 4 {
            throw YumemiWeatherError.unknownError
        }

        let areas = request.areas.isEmpty ? Area.allCases : request.areas.compactMap { Area(rawValue: $0) }
        let response = areas.map { AreaResponse(area: $0, info: makeRandomResponse(date: request.date)) }
        let responseData = try encoder.encode(response)

        return String(data: responseData, encoding: .utf8)!
    }

    /// 擬似 天気予報一覧API Sync ver
    /// - Parameter jsonString: 地域と日付を含むJson文字列
    /// example:
    /// {
    ///   "areas": ["Tokyo"],
    ///   "date": "2020-04-01T12:00:00+09:00"
    /// }
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Returns: Json文字列
    static func syncFetchWeatherList(_ jsonString: String) throws -> String {
        Thread.sleep(forTimeInterval: apiDuration)
        return try self.fetchWeatherList(jsonString)
    }

    /// 擬似 天気予報一覧API Callback ver
    /// - Parameters:
    ///   - jsonString: 地域と日付を含むJson文字列
    /// example:
    /// {
    ///   "areas": ["Tokyo"],
    ///   "date": "2020-04-01T12:00:00+09:00"
    /// }
    ///   - completion: 完了コールバック
    static func callbackFetchWeatherList(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + apiDuration) {
            do {
                let response = try fetchWeatherList(jsonString)
                completion(Result.success(response))
            }
            catch let error where error is YumemiWeatherError {
                completion(Result.failure(error as! YumemiWeatherError))
            }
            catch {
                fatalError()
            }
        }
    }

    /// 擬似 天気予報一覧API Async ver
    /// - Parameter jsonString: 地域と日付を含むJson文字列
    /// example:
    /// {
    ///   "areas": ["Tokyo"],
    ///   "date": "2020-04-01T12:00:00+09:00"
    /// }
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Returns: Json文字列
    @available(iOS 13, macOS 10.15, *)
    static func asyncFetchWeatherList(_ jsonString: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            callbackFetchWeatherList(jsonString) { result in
                continuation.resume(with: result)
            }
        }
    }
}
