//
//  TimeConversion.swift
//  FirstChallengeAllUnits
//
//  Created by Nikita Kolomoec on 09.04.2023.
//
import SwiftUI

enum Time: String, CaseIterable {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
}

struct TimeConversion: View {
    @State private var firstTime: Time = .hours
    @State private var secondTime: Time = .days
    
    @State private var firstUnit = 0.0
    
    var total: Double {
        switch (firstTime, secondTime) {
        case (.minutes, .minutes):
            return firstUnit
        case (.minutes, .hours):
            return firstUnit / 60
        case (.minutes, .days):
            return firstUnit / 1440
        case (.hours, .minutes):
            return firstUnit * 60
        case (.hours, .hours):
            return firstUnit
        case (.hours, .days):
            return firstUnit / 24
        case (.days, .minutes):
            return firstUnit * 1440
        case (.days, .hours):
            return firstUnit * 24
        case (.days, .days):
            return firstUnit
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your value", value: $firstUnit, format: .number)
                    .keyboardType(.decimalPad)
                Picker("", selection: $firstTime) {
                    ForEach(Time.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Select your first Unit")
            }
            
            Section {
                Picker("", selection: $secondTime) {
                    ForEach(Time.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Transfer \(secondTime.rawValue) to")
            }
            Section {
                Text(total, format: .number)
            } header: {
                Text("\(firstUnit, format: .number) \(firstTime.rawValue) in \(secondTime.rawValue) is")
            }
        }
    }
}


struct TimeConversion_Previews: PreviewProvider {
    static var previews: some View {
        TimeConversion()
    }
}
