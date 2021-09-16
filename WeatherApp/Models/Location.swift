//
//  Location.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation
import RxDataSources

struct Location: Codable {
    var id: Int
    var name: String
    var state: String
    var country: String
    var coord: Coord
    
    struct Coord: Codable {
        var lat: Double
        var lon: Double
    }
}

extension Location.Coord: Hashable {
    static func == (lhs: Location.Coord, rhs: Location.Coord) -> Bool {
        return lhs.lat == rhs.lat &&
            lhs.lon == rhs.lon
    }
}

extension Location: Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.state == rhs.state &&
            lhs.country == rhs.country &&
            lhs.coord == rhs.coord
    }
}

extension Location: IdentifiableType {
    typealias Identity = Int
    var identity: Int { self.id }
}
