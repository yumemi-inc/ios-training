//
//  TestMethods.swift
//
//  
//  Created by Tomohiro Kumagai on 2024/05/02
//  
//

import XCTest
@testable import YumemiWeather

/// 失敗数が想定内かを判定します。
/// - Parameters:
///   - probability: 失敗率です。
///   - tryingCount: 総試行回数です。
///   - failureCount: うち、失敗した回数です。
///   - file: 判定コードが記載されたファイルです。
///   - line: 判定コードが記載された行です。
func XCTAssertFailureCount(probability: Double, tryingCount: Int, failureCount: Int, file: StaticString = #filePath, line: UInt = #line) {
    
    let estimatedFailureCount = Double(tryingCount) * probability
    let expectedFailureMargin = Double(tryingCount) * 0.01

    let expectedFailureRange = estimatedFailureCount - expectedFailureMargin ..< estimatedFailureCount + expectedFailureMargin

    XCTAssertTrue(expectedFailureRange.contains(Double(failureCount)), "Failures: \(failureCount), Estimated failures = \(estimatedFailureCount)±\(expectedFailureMargin)", file: file, line: line)
}

/// YumemiWether API の品質をテストします。
/// - Parameters:
///   - tryingCount: 総試行回数です。
///   - quality: API の想定品質です。
///   - file: 判定コードが記載されたファイルです。
///   - line: 判定コードが記載された行です。
func XCTAssertAPIQuality(_ predicate: () throws -> Void, tryingCount: Int, quality: YumemiWeather.APIQuality, file: StaticString = #filePath, line: UInt = #line) {
        
    var succeededCount = 0
    var failedCount = 0
    
    YumemiWeather.apiQuality = quality
    
    for _ in 0 ..< tryingCount {

        switch Result(catching: predicate) {
            
        case .success():
            succeededCount += 1
            
        case .failure(_):
            failedCount += 1
        }
    }
    
    switch quality {
        
    case .neverFails:
        XCTAssertEqual(succeededCount, tryingCount, file: file, line: line)
        XCTAssertEqual(failedCount, 0, file: file, line: line)
        
    case .alwaysFails:
        XCTAssertEqual(succeededCount, 0, file: file, line: line)
        XCTAssertEqual(failedCount, tryingCount, file: file, line: line)

    case .sometimesFails(let probability):
        XCTAssertFailureCount(probability: probability, tryingCount: tryingCount, failureCount: failedCount, file: file, line: line)
    }
}
