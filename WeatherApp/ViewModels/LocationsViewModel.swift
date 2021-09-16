//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 15/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class LocationsViewModel {
    
    var locations = BehaviorRelay<[Location]>(value: [])
    var count: Int { locations.value.count }
    private var defaults: UserDefaults { UserDefaults.standard }
    private let disposeBag = DisposeBag()
    
    init() {
        loadLocations()
        locations
            .asDriver()
            .drive(onNext: { [weak self] locations in
                self?.saveLocations()
            })
            .disposed(by: disposeBag)
    }
    
    private func loadLocations() {
        if let locations = defaults.object(forKey: "locations") as? Data {
            do {
                let newValue = try JSONDecoder().decode([Location].self, from: locations)
                self.locations.accept(newValue)
            } catch {
                print("Failed to load locations.")
            }
        }
    }
    
    private func saveLocations() {
        if let data = try? JSONEncoder().encode(locations.value) {
            defaults.set(data, forKey: "locations")
        } else {
            print("Failed to save data.")
        }
    }
}
