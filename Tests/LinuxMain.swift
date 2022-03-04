import XCTest

import YumemiWeatherTests

var tests = [XCTestCaseEntry]()
tests += YumemiWeatherTests.allNonConcurrentTests()
if #available(iOS 13, macOS 10.15) {
    tests += YumemiWeatherTests.allConcurrentTests
}
XCTMain(tests)
