//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by 李昀 on 2023/11/15.
//

import Foundation

struct WeatherForecast: Codable {
    let properties: WeatherForecastProperty
}

struct WeatherForecastProperty: Codable {
    let periods: [WeatherForecastPeriod]
}

struct WeatherForecastPeriod: Codable {
    let number: Int
    let startTime: String
    let endTime: String
    let temperature: Int
    let shortForecast: String
    let detailedForecast: String
}
