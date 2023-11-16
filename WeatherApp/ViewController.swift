//
//  ViewController.swift
//  WeatherApp
//
//  Created by 李昀 on 2023/10/31.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService(networkManager: NetworkManager()).fetchWeatherOverview(latitude: 40.4406, longitude: -79.9959) { weatherOverviewProperty, error in
            if let error = error {
                debugPrint("error", error)
                return
            }
            print("weatherOverviewProperty", weatherOverviewProperty)
            WeatherService(networkManager: NetworkManager()).fetchWeatherForecast(gridId: weatherOverviewProperty!.gridId, gridX: weatherOverviewProperty!.gridX, gridY: weatherOverviewProperty!.gridY, forecastType: .hourly) { weatherForecastProperty, error in
                if let error = error {
                    debugPrint("error", error)
                    return
                }
                print("weatherForecastProperty", weatherForecastProperty)
            }
        }
    }
    
    
    
    
}

