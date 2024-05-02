import XCTest
@testable import YumemiWeather

final class YumemiWeatherTests: XCTestCase {

    func test_ランダムにレスポンスを生成する() {

        // 日付を省略すると実行した瞬間のものが得られてしまうため、
        // テストするために固定とします。
        let date = Date()
        
        func makeRandomResponse(withSeed seed: Int) -> Response {
            
            ControllableGenerator.reset(withSeed: seed)
            return YumemiWeather.makeRandomResponse(using: &ControllableGenerator.shared, date: date)
        }

        let response1 = makeRandomResponse(withSeed: 0)
        let response2 = makeRandomResponse(withSeed: 1546000)
        let response3 = makeRandomResponse(withSeed: 0)
        let response4 = makeRandomResponse(withSeed: 1546000)

        XCTAssertEqual(response1, response3)
        XCTAssertEqual(response2, response4)
        
        XCTAssertEqual(response1.weatherCondition, "sunny")
        XCTAssertEqual(response1.minTemperature, -33)
        XCTAssertEqual(response1.maxTemperature, 33)
        XCTAssertEqual(response1.date, date)
        
        XCTAssertEqual(response2.weatherCondition, "cloudy")
        XCTAssertEqual(response2.minTemperature, 23)
        XCTAssertEqual(response2.maxTemperature, 28)
        XCTAssertEqual(response2.date, date)
        
        XCTAssertEqual(response3.weatherCondition, "sunny")
        XCTAssertEqual(response3.minTemperature, -33)
        XCTAssertEqual(response3.maxTemperature, 33)
        XCTAssertEqual(response3.date, date)
        
        XCTAssertEqual(response4.weatherCondition, "cloudy")
        XCTAssertEqual(response4.minTemperature, 23)
        XCTAssertEqual(response4.maxTemperature, 28)
        XCTAssertEqual(response4.date, date)
    }
    
    func test_fetchWeather() {
        let str = YumemiWeather.fetchWeatherCondition()
        XCTAssertNotNil(WeatherCondition(rawValue: str))
    }

    func test_fetchWeather_at() {
        do {
            let str = try YumemiWeather.fetchWeatherCondition(at: "Tokyo")
            XCTAssertNotNil(WeatherCondition(rawValue: str))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

    func test_fetchWeather_jsonString() {
        let parameter = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
        do {
            let responseJSON = try YumemiWeather.fetchWeather(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            _ = try decoder.decode(Response.self, from: Data(responseJSON.utf8))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

    func test_fetchWeather_jsonString_sync() {
        let beginDate = Date()
        let parameter = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
        do {
            let responseJSON = try YumemiWeather.syncFetchWeather(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            _ = try decoder.decode(Response.self, from: Data(responseJSON.utf8))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }

        XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(beginDate), YumemiWeather.apiDuration)
    }

    func test_fetchWeather_jsonString_callback() {
        let parameter = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
        let exp = expectation(description: #function)
        YumemiWeather.callbackFetchWeather(parameter) { result in
            exp.fulfill()
            switch result {
            case .success(let jsonString):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                XCTAssertNoThrow(try! decoder.decode(Response.self, from: Data(jsonString.utf8)))
            case .failure(let error):
                XCTAssertEqual(error, YumemiWeatherError.unknownError)
            }
        }
        wait(for: [exp], timeout: YumemiWeather.apiDuration + 0.1)
    }

    @available(iOS 13, macOS 10.15, *)
    func test_fetchWeather_jsonString_async() async {
        let beginDate = Date()
        let parameter = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
        do {
            let responseJSON = try await YumemiWeather.asyncFetchWeather(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            _ = try decoder.decode(Response.self, from: Data(responseJSON.utf8))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }

        XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(beginDate), YumemiWeather.apiDuration)
    }

    static var allNonConcurrentTests = [
        ("test_fetchWeather", test_fetchWeather),
        ("test_fetchWeather_at", test_fetchWeather_at),
        ("test_fetchWeather_jsonString", test_fetchWeather_jsonString),
        ("test_fetchWeather_jsonString_sync", test_fetchWeather_jsonString_sync),
        ("test_fetchWeather_jsonString_callback", test_fetchWeather_jsonString_callback),
    ]

    @available(iOS 13, macOS 10.15, *)
    static var allConcurrentTests = [
        ("test_fetchWeather_jsonString_async", test_fetchWeather_jsonString_async),
    ]
}
