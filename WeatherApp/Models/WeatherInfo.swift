//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 05/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    var coord: Coord
    var weather: [Weather]
    var main: Main
    var name: String
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

