import Foundation

struct Request: Decodable {
    let area: String
    let date: Date
}

struct Response: Codable, Equatable {
    let weatherCondition: String
    let maxTemperature: Int
    let minTemperature: Int
    let date: Date
}

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

public enum YumemiWeatherError: Error {
    case invalidParameterError
    case unknownError
}

/// 天気予報を取得する擬似天気予報 API です。
///
/// ゆめみ iOS 研修用の実装であり、実際の天気予報ではなくランダムな天気予報が得られます。
/// 研修効果を高めるため、さまざまなバージョンの API が用意されていて、
/// その中には適切なパラメーターを与えたときでも一定の確率でエラーを返すものもあります。
final public class YumemiWeather {

    /// 天気予報を読み込む API の Simple Version です。
    /// - Returns: 天気状況を表す文字列 "sunny" or "cloudy" or "rainy"
    public static func fetchWeatherCondition() -> String {
        return makeRandomResponse().weatherCondition
    }

    /// 天気予報を読み込む API の Throwing Version です。
    /// - Throws: YumemiWeatherError
    /// - Parameters:
    ///   - area: 天気予報を取得する対象地域 example: "tokyo"
    /// - Returns: 天気状況を表す文字列 "sunny" or "cloudy" or "rainy"
    public static func fetchWeatherCondition(at area: String) throws -> String {
        try introduceInstability()
        return self.makeRandomResponse().weatherCondition
    }

    /// 天気予報を読み込む API の JSON Version です。
    ///
    /// JSON 文字列で地域情報 `area` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// 取得された天気予報は速やかに返されます。
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    public static func fetchWeather(_ jsonString: String) throws -> String {
        guard let requestData = jsonString.data(using: .utf8),
              let request = try? decoder.decode(Request.self, from: requestData) else {
            throw YumemiWeatherError.invalidParameterError
        }

        let response = makeRandomResponse(date: request.date)
        let responseData = try encoder.encode(response)

        try introduceInstability()
        return String(data: responseData, encoding: .utf8)!
    }

    /// 天気予報を読み込む API の Sync Version です。
    ///
    /// JSON 文字列で地域情報 `area` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は同期的に実行され、天気予報を返すまでに若干時間がかかります。
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    public static func syncFetchWeather(_ jsonString: String) throws -> String {
        Thread.sleep(forTimeInterval: apiDuration)
        return try fetchWeather(jsonString)
    }
    
    /// 天気予報を読み込む API の Callback Version です。
    ///
    /// JSON 文字列で地域情報 `area` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は非同期的に実行され、天気予報を取得できるとその結果を添えて `completion` を呼び出します。
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 成功に返された天気 Result の中に JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// また、YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameters:
    ///   - jsonString: 地域と日付を含む JSON 文字列
    ///   - completion: 完了コールバック
    public static func callbackFetchWeather(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + apiDuration) {
            do {
                let response = try fetchWeather(jsonString)
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

    /// 天気予報を読み込む API の Async Version です。
    ///
    /// JSON 文字列で地域情報 `area` と日付情報 `date` を持つオブジェクトを受け取って、それに該当する天気予報を取得します。
    /// この API は非同期的に実行され、天気予報を取得できるまでは Swift Concurrency により処理が中断されます。
    /// 
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    @available(iOS 13, macOS 10.15, *)
    public static func asyncFetchWeather(_ jsonString: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            callbackFetchWeather(jsonString) { result in
                continuation.resume(with: result)
            }
        }
    }
}

extension YumemiWeather {
    
    static let apiDuration: TimeInterval = 2

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
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
