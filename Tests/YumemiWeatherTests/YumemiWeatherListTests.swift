import XCTest
@testable import YumemiWeather

final class YumemiWeatherListTests: XCTestCase {
    
    func test_fetchWeatherList_jsonString() {
        let parameter = """
{
    "areas": [],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJson = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJson.utf8))
            XCTAssertEqual(response.count, Area.allCases.count)
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

    func test_fetchWeatherList_jsonString_one() {
        let parameter = """
{
    "areas": ["Tokyo"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJson = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJson.utf8))
            XCTAssertEqual(response.count, 1)
            let tokyo = response.first
            XCTAssertEqual(tokyo?.area, .Tokyo)
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

    func test_fetchWeatherList_jsonString_two() {
        let parameter = """
{
    "areas": ["Tokyo", "Nagoya"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJson = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJson.utf8))
            XCTAssertEqual(response.count, 2)
            let tokyo = response.first(where: { $0.area == .Tokyo })
            XCTAssertNotNil(tokyo)
            let nagoya = response.first(where: { $0.area == .Nagoya })
            XCTAssertNotNil(nagoya)
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

    func test_fetchWeatherList_jsonString_none() {
        let parameter = """
{
    "areas": ["LosAngeles"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJson = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJson.utf8))
            XCTAssertEqual(response.count, 0)
        }
        catch let error as YumemiWeatherError {
            XCTAssertEqual(error, YumemiWeatherError.unknownError)
        }
        catch {
            XCTFail()
        }
    }

}
