//
//  ContentView.swift
//  WeSplit
//
//  Created by Vanda Savkina on 08/02/24.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var SelectedStudent = "Harry"
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
//    let tipPercentages = [10, 15, 20, 25, 0]
    let tipPercentages: [Int]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalPlusTip: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    @FocusState private var amountFocused: Bool
    
    
//    private func totalPerPerson(total: Double, people: Int, tip: Int) -> Double {
//        (checkAmount + (checkAmount * Double(tipPercentage) / 100)) / Double(numberOfPeople)
//    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $SelectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total amount") {
                    Text(totalPlusTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountFocused {
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(tipPercentages: [0])
}
