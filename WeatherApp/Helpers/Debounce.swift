//
//  Debounce.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 15/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import Foundation

class Debounce<T: Equatable> {
    
    private init() {}
    
    static func input(_ input: T,
                      comparedAgainst current: @escaping @autoclosure () -> (T),
                      perform: @escaping (T) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if input == current() { perform(input) }
        }
    }
}
