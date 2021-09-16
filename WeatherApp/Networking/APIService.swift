//
//  APIService.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

enum API {
    static let key = "e4bc3c619491174a8469fe64cb6dc7ea"
}

class APIService: NSObject {
    
    enum APIResult {
        case success(WeatherInfo)
        case failure
    }
    
    private static let apiKey = "e4bc3c619491174a8469fe64cb6dc7ea"
    var cityName = "Zagreb"
    
    func fetchWeather(for id: Int, completion: @escaping (APIResult) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(id)&appid=\(API.key)&units=metric") {
                if let data = try? Data(contentsOf: url) {
                    let jsonDecoder = JSONDecoder()
                    if let weatherInfo = try? jsonDecoder.decode(WeatherInfo.self, from: data) {
                        if weatherInfo.weather.count > 0 {
                            completion(.success(weatherInfo))
                            return
                        }
                    }
                }
            }
            completion(.failure)
        }
    }
    
    func fetchMultipleWeathers(for ids: [Int], completion: @escaping (APIResult) -> Void) {
        let idsString = ids.map { String($0) }.joined(separator: ",")
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: "https://api.openweathermap.org/group/2.5/weather?id=\(idsString)&appid=\(API.key)&units=metric") {
                if let data = try? Data(contentsOf: url) {
                    let jsonDecoder = JSONDecoder()
                    if let weatherInfos = try? jsonDecoder.decode(WeatherInfo.self, from: data) {
                        completion(.success(weatherInfos))
                        return
                    }
                }
            }
            completion(.failure)
        }
    }
}
