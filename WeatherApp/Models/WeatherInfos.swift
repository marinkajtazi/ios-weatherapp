//
//  WeatherInfos.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 14/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

struct WeatherInfos: Codable {
    var cnt: Int
    var list: [WeatherInfo]
}
