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
    
}
