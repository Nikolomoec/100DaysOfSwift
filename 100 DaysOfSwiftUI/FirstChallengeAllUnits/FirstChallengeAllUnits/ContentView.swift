//
//  ContentView.swift
//  FirstChallengeAllUnits
//
//  Created by Nikita Kolomoec on 09.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink("Temperature Conversation", destination: {
                        TemperatureConversion()
                            .navigationTitle("Temperature")
                    })
                }
                Section {
                    NavigationLink("Length Conversation", destination: {
                        LengthConversion()
                            .navigationTitle("Length")
                    })
                }
                Section {
                    NavigationLink("Time Conversation", destination: {
                        TimeConversion()
                            .navigationTitle("Time")
                    })
                }
                Section {
                    NavigationLink("Volume Conversation", destination: {
                        VolumeConversion()
                            .navigationTitle("Volume")
                    })
                }
            }
            .navigationTitle("Unit Conversions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
