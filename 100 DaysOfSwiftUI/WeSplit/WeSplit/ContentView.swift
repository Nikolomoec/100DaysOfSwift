//
//  ContentView.swift
//  WeSplit
//
//  Created by Nikita Kolomoec on 08.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    var checkPlusTip: Double {
        let tipPercentage = Double(tipPercentage)
        let tip = checkAmount / 100 * tipPercentage
        return checkAmount + tip
    }
    
    var total: Double {
        let people = Double(numOfPeople + 2)
        let tipPercentage = Double(tipPercentage)
        let tip = checkAmount / 100 * tipPercentage
        let checkPlusTip = checkAmount + tip
        
        return checkPlusTip / people
    }
    
    let code = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: code))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    Picker("Select Tip %", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(checkPlusTip, format: .currency(code: code))
                } header: {
                    Text("Amount you are paying with a tip")
                }
                
                Section {
                    Text(total, format: .currency(code: code))
                } header: {
                    Text("Amount per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isFocused.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
