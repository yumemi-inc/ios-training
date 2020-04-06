import XCTest
@testable import YumemiWeather

final class YumemiWeatherTests: XCTestCase {
    
    func test_fetchWeather() {
        let str = YumemiWeather.fetchWeather()
        XCTAssertNotNil(Weather(rawValue: str))
    }
    
    func test_fetchWeather_at() {
        do {
            let str = try YumemiWeather.fetchWeather(at: "tokyo")
            XCTAssertNotNil(Weather(rawValue: str))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_fetchWeather_jsonString_sync() {
        let parameter = """
{
    "area": "tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJson = try YumemiWeather.fetchWeather(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            _ = try decoder.decode(Response.self, from: Data(responseJson.utf8))
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_fetchWeather_jsonString_async() {
        let parameter = """
{
    "area": "tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        let exp = expectation(description: #function)
        YumemiWeather.fetchWeather(parameter) { result in
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
        self.wait(for: [exp], timeout: 1.1)
    }

    static var allTests = [
        ("test_fetchWeather", test_fetchWeather),
        ("test_fetchWeather_at", test_fetchWeather_at),
        ("test_fetchWeather_jsonString_sync", test_fetchWeather_jsonString_sync),
        ("test_fetchWeather_jsonString_async", test_fetchWeather_jsonString_async),
    ]
}
