//
//  WeatherService.swift
//  WeatherApp
//
//  Created by 李昀 on 2023/11/15.
//

import Foundation
import CoreLocation

protocol WeatherFetching {
    func fetchWeatherOverview(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherOverviewProperty?, Error?) -> Void)
    
    func fetchWeatherForecast(gridId: String, gridX: Int, gridY: Int, completion: @escaping (WeatherForecastProperty?, Error?) -> Void)
}

class WeatherService: WeatherFetching {
    
    private var networkManager: NetworkManager
    private let baseUrl = "https://api.weather.gov/"
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchWeatherOverview(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherOverviewProperty?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/points/\(latitude),\(longitude)") else {
            fatalError("Invalid URL")
        }
        networkManager.request(fromURL: url, httpMethod: .get) { (result: Result<WeatherOverview, Error>) in
            switch result {
            case .success(let weatherOverview):
                completion(weatherOverview.properties, nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func fetchWeatherForecast(gridId: String, gridX: Int, gridY: Int, completion: @escaping (WeatherForecastProperty?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/gridpoints/\(gridId)/\(gridX),\(gridY)/forecast") else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(fromURL: url, httpMethod: .get) { (result: Result<WeatherForecast, Error>) in
            switch result {
            case .success(let weatherForecast):
                completion(weatherForecast.properties, nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    
}
