//
//  BehaviorRelay+ConvenienceMethods.swift
//  WeatherApp
//
//  Created by Marin Kajtazi on 20/10/2020.
//  Copyright © 2020 Marin Kajtazi. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
    
    func insert(_ element: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(element, at: index)
        accept(newValue)
    }
    
    func remove(at index: Element.Index) -> Element.Element {
        var newValue = value
        let element = newValue.remove(at: index)
        
        accept(newValue)
        return element
    }
    
    func moveElement(from srcIndex: Element.Index, to dstIndex: Element.Index) {
        var newValue = value
        let element = newValue.remove(at: srcIndex)
        
        newValue.insert(element, at: dstIndex)
        accept(newValue)
    }
}
