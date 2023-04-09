//
//  LengthConversion.swift
//  FirstChallengeAllUnits
//
//  Created by Nikita Kolomoec on 09.04.2023.
//

import SwiftUI

enum Length: String, CaseIterable {
    case meters = "Meters"
    case miles = "Miles"
    case feet = "Feet"
}

struct LengthConversion: View {
    @State private var firstLength: Length = .meters
    @State private var secondLength: Length = .miles
    
    @State private var firstUnit = 0.0
    
    var total: Double {
        switch (firstLength, secondLength) {
        case (.meters, .meters):
            return firstUnit
        case (.meters, .miles):
            return firstUnit / 1609
        case (.meters, .feet):
            return firstUnit * 3.28
        case (.miles, .meters):
            return firstUnit * 1609
        case (.miles, .miles):
            return firstUnit
        case (.miles, .feet):
            return firstUnit * 5280
        case (.feet, .meters):
            return firstUnit / 3.28
        case (.feet, .miles):
            return firstUnit / 5280
        case (.feet, .feet):
            return firstUnit
        }
    }
    
    var body: some View {
        
        
        Form {
            Section {
                TextField("Enter your value", value: $firstUnit, format: .number)
                    .keyboardType(.decimalPad)
                Picker("", selection: $firstLength) {
                    ForEach(Length.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Select your first Unit")
            }
            
            Section {
                Picker("", selection: $secondLength) {
                    ForEach(Length.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Transfer \(secondLength.rawValue) to")
            }
            Section {
                Text(total, format: .number)
            } header: {
                Text("\(firstUnit, format: .number) \(firstLength.rawValue) in \(secondLength.rawValue) is")
            }
        }
    }
}


struct LengthConversion_Previews: PreviewProvider {
    static var previews: some View {
        LengthConversion()
    }
}
