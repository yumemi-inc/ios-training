//
//  Response.swift
//  

import Foundation

struct Response: Codable, Equatable {
    let weatherCondition: String
    let maxTemperature: Int
    let minTemperature: Int
    let date: Date
}
