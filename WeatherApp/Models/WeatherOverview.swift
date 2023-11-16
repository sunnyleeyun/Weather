//
//  WeatherOverview.swift
//  WeatherApp
//
//  Created by 李昀 on 2023/11/15.
//

import Foundation

struct WeatherOverview: Codable {
    let properties: WeatherOverviewProperty
}

struct WeatherOverviewProperty: Codable {
    let gridId: String
    let gridX: Int
    let gridY: Int
}
