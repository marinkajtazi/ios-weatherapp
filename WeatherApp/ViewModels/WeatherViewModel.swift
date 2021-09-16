//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    private var apiService = APIService()
    var weatherInfo: WeatherInfo?
    var location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func fetchWeatherData(onSuccess: @escaping () -> Void, onFail: @escaping () -> Void) {
        apiService.fetchWeather(for: location.id) { [weak self] result in
            switch result {
            case .success(let weatherInfo):
                self?.weatherInfo = weatherInfo
                onSuccess()
            case .failure:
                onFail()
            }
        }
    }
}
