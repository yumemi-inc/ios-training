//
//  YumemiWeatherList.swift
//
//
//  Created by 古宮 伸久 on 2022/04/04.
//

import Foundation

public extension YumemiWeather {

    /// 天気予報一覧を読み込む API の JSON Version です。
    ///
    /// JSON 文字列で地域情報 `areas` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// 取得された天気予報は速やかに返されます。
    ///
    /// 地域情報は配列で複数の地域を一括指定し、それらの地域の天気予報を取得できます。地域を指定しない場合は全地域の天気予報を取得します。
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "areas": ["Tokyo"],
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
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

        try introduceInstability()

        let areas = request.areas.isEmpty ? Area.allCases : request.areas.compactMap { Area(rawValue: $0) }
        let areaResponses = areas.map { area -> AreaResponse in
            ControllableGenerator.resetUsing(area: area, date: request.date)
            return AreaResponse(area: area, info: makeRandomResponse(using: &ControllableGenerator.shared, date: request.date))
        }
        let responseData = try encoder.encode(areaResponses)

        return String(data: responseData, encoding: .utf8)!
    }

    /// 天気予報一覧を読み込む API の Sync Version です。
    ///
    /// JSON 文字列で地域情報 `areas` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は同期的に実行され、天気予報を返すまでに若干時間がかかります。
    ///
    /// 地域情報は配列で複数の地域を一括指定し、それらの地域の天気予報を取得できます。地域を指定しない場合は全地域の天気予報を取得します。
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
        return try fetchWeatherList(jsonString)
    }

    /// 天気予報一覧を読み込む API の Callback Version です。
    ///
    /// JSON 文字列で地域情報 `areas` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は非同期的に実行され、天気予報を取得できるとその結果を添えて `completion` を呼び出します。
    ///
    /// 地域情報は配列で複数の地域を一括指定し、それらの地域の天気予報を取得できます。地域を指定しない場合は全地域の天気予報を取得します。
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
    static func callbackFetchWeatherList(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void) {
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

    /// 天気予報一覧を読み込む API の Async Version です。
    ///
    /// JSON 文字列で地域情報 `areas` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は非同期的に実行され、天気予報を取得できるまでは Swift Concurrency により処理が中断されます。
    ///
    /// 地域情報は配列で複数の地域を一括指定し、それらの地域の天気予報を取得できます。地域を指定しない場合は全地域の天気予報を取得します。
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
            callbackFetchWeatherList(jsonString) { result in
                continuation.resume(with: result)
            }
        }
    }
}
