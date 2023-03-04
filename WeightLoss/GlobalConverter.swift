//
//  GlobalConverter.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 11.02.2023.
//

import Foundation

class GlobalClass {
    static let shared = GlobalClass()
    private init() {}

    // Add properties and methods here that you want to access globally
    
    
    func convertToCentimetersFromFeet(feet: Double) -> Double {
        return feet * 30.48
    }
    
    func convertToKilograms(pounds: Double) -> Double {
        return pounds / 2.20462
    }

}
