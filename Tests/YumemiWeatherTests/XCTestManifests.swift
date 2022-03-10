import XCTest

#if !canImport(ObjectiveC)
public func allNonConcurrentTests() -> [XCTestCaseEntry] {
    return [
        testCase(YumemiWeatherTests.allNonConcurrentTests),
    ]
}
public func allConcurrentTests() -> [XCTestCaseEntry] {
    return [
        testCase(YumemiWeatherTests.allConcurrentTests),
    ]
}
#endif
