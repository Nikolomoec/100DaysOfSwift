//
//  TemperatureConversion.swift
//  FirstChallengeAllUnits
//
//  Created by Nikita Kolomoec on 09.04.2023.
//

import SwiftUI

enum Temperatures: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct TemperatureConversion: View {
    @State private var firstTemperature: Temperatures = .celsius
    @State private var secondTemperature: Temperatures = .fahrenheit
    
    @State private var firstUnit = 0.0
    
    var total: Double {
        switch (firstTemperature, secondTemperature) {
        case (.celsius, .celsius):
            return firstUnit
        case (.celsius, .fahrenheit):
            return (firstUnit * 1.8) + 32
        case (.celsius, .kelvin):
            return firstUnit + 273.15
        case (.fahrenheit, .celsius):
            return (firstUnit - 32) * 0.5556
        case (.fahrenheit, .fahrenheit):
            return firstUnit
        case (.fahrenheit, .kelvin):
            return (firstUnit + 459.67) * 0.5556
        case (.kelvin, .celsius):
            return firstUnit - 273.15
        case (.kelvin, .fahrenheit):
            return (firstUnit - 273.15) * 1.8 + 32
        case (.kelvin, .kelvin):
            return firstUnit
        }
    }
    
    var body: some View {
            Form {
                Section {
                    TextField("Enter your value", value: $firstUnit, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $firstTemperature) {
                        ForEach(Temperatures.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select your first Unit")
                }
                
                Section {
                    Picker("", selection: $secondTemperature) {
                        ForEach(Temperatures.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Transfer \(firstTemperature.rawValue) to")
                }
                Section {
                    Text("\(total)°")
                } header: {
                    Text("\(firstUnit, format: .number) \(firstTemperature.rawValue) in \(secondTemperature.rawValue) is")
                }
            }
    }
}

struct TemperatureConversion_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversion()
    }
}
