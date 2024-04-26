import XCTest
@testable import YumemiWeather

final class YumemiWeatherListTests: XCTestCase {

    func test_Areasに空を指定したときに全ての地域が取得される() throws {
        
        let request = """
        {
            "areas": [],
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
        
        let responseJSON = try YumemiWeather.fetchWeatherList(request)
        
        guard let responseData = responseJSON.data(using: .utf8) else {
            XCTFail("Illegal response data: \(responseJSON)")
            return
        }
        
        let response = try YumemiWeather.decoder.decode([AreaResponse].self, from: responseData)
        
        XCTAssertEqual(response.map(\.area), Area.allCases)
    }
    
    func test_fetchWeatherList_jsonString() {
        let parameter = """
{
    "areas": [],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJSON = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJSON.utf8))
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
    "areas": ["tokyo"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJSON = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJSON.utf8))
            XCTAssertEqual(response.count, 1)
            let tokyo = response.first
            XCTAssertEqual(tokyo?.area, .tokyo)

            let responseJSON2 = try YumemiWeather.fetchWeatherList(parameter)
            let response2 = try decoder.decode([AreaResponse].self, from: Data(responseJSON2.utf8))
            let tokyo2 = response2.first
            XCTAssertEqual(tokyo?.info, tokyo2?.info)
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
    "areas": ["tokyo", "nagoya"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJSON = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJSON.utf8))
            XCTAssertEqual(response.count, 2)
            let tokyo = response.first(where: { $0.area == .tokyo })
            XCTAssertNotNil(tokyo)
            let nagoya = response.first(where: { $0.area == .nagoya })
            XCTAssertNotNil(nagoya)
            XCTAssertNotEqual(tokyo?.info, nagoya?.info)
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
    "areas": ["losAngeles"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        do {
            let responseJSON = try YumemiWeather.fetchWeatherList(parameter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let response = try decoder.decode([AreaResponse].self, from: Data(responseJSON.utf8))
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
