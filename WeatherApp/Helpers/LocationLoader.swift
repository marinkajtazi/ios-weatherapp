//
//  LocationLoader.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 21/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

class LocationLoader {
    
    enum State {
        case loaded([Location])
        case notLoaded
    }
    
    static let shared = LocationLoader()
    private(set) var state = State.notLoaded
    
    private init() { }
    
    func loadLocationsAsync() {
        DispatchQueue.global().async { [unowned self] in
            guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else {
                fatalError("Missing locations for search functionality.")
            }
            
            let url = URL(fileURLWithPath: path)
            
            do {
                let jsonData = try Data(contentsOf: url)
                let locations = try JSONDecoder().decode([Location].self, from: jsonData)
                self.state = .loaded(locations)
            } catch {
                fatalError("Failed to decode locations.")
            }
        }
    }
}
