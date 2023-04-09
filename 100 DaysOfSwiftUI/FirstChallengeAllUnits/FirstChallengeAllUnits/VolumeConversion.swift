//
//  VolumeConversion.swift
//  FirstChallengeAllUnits
//
//  Created by Nikita Kolomoec on 09.04.2023.
//

import SwiftUI

enum Volume: String, CaseIterable {
    case milliliters = "Milliliters"
    case liters = "Liters"
    case cups = "Cups"
}

struct VolumeConversion: View {
    @State private var firstVolume: Volume = .liters
    @State private var secondVolume: Volume = .cups
    
    @State private var firstUnit = 0.0
    
    var total: Double {
        switch (firstVolume, secondVolume) {
        case (.milliliters, .milliliters):
            return firstUnit
        case (.milliliters, .liters):
            return firstUnit / 1000
        case (.milliliters, .cups):
            return firstUnit / 236.6
        case (.liters, .milliliters):
            return firstUnit * 1000
        case (.liters, .liters):
            return firstUnit
        case (.liters, .cups):
            return firstUnit * 4.227
        case (.cups, .milliliters):
            return firstUnit * 236.6
        case (.cups, .liters):
            return firstUnit / 4.227
        case (.cups, .cups):
            return firstUnit
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your value", value: $firstUnit, format: .number)
                    .keyboardType(.decimalPad)
                Picker("", selection: $firstVolume) {
                    ForEach(Volume.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Select your first Unit")
            }
            
            Section {
                Picker("", selection: $secondVolume) {
                    ForEach(Volume.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Transfer \(secondVolume.rawValue) to")
            }
            Section {
                Text(total, format: .number)
            } header: {
                Text("\(firstUnit, format: .number) \(firstVolume.rawValue) in \(secondVolume.rawValue) is")
            }
        }
    }
}


struct VolumeConversion_Previews: PreviewProvider {
    static var previews: some View {
        VolumeConversion()
    }
}
