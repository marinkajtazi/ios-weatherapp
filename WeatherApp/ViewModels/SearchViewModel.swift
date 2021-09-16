//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 13/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    private var locations: [Location]
    var filteredLocations = BehaviorRelay<[Location]>(value: [])
    var count: Int { filteredLocations.value.count }
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    //func location(at index: Int) -> Location {
    //    filteredLocations[index]
    //}
    
    func filter(by query: String) {
        var newValue = locations.filter { location in
            location.name.range(of: query, options: .caseInsensitive) != nil
        }
        newValue.sort { $0.name > $1.name }
        filteredLocations.accept(newValue)
    }
}
