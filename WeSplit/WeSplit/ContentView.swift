//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael VanDyke on 11/5/21.
//

import SwiftUI

struct ContentView: View {
	@State private var checkTotal = 0.0
	@State private var totalDivisions = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	private let tipPercentages = [10, 15, 20, 25, 0]
	
	private var totalCheckWithTip: Double {
		let tipSelection = Double(tipPercentage)
		let tipValue = checkTotal / 100 * tipSelection
		let grandTotal = checkTotal + tipValue
		
		return grandTotal
	}
	
	private var totalPerPerson: Double {
		let peopleCount = Double(totalDivisions)
		let amountPerPerson = totalCheckWithTip / peopleCount
		return amountPerPerson
	}

    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Check Total", value: $checkTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of People", selection: $totalDivisions) {
						ForEach(2...10, id: \.self) {
							Text("\($0) people")
						}
					}
				} header: {
					Text("Cost of check")
				}
				
				Section {
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}.pickerStyle(.segmented)
				} header: {
					Text("How much tip do you want to leave?")
				}
				
				Section {
					Text(totalCheckWithTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
				} header: {
					Text("Total Check Cost with tip")
				}
				
				Section {
					Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
				} header: {
					Text("Total cost per person")
				}
			}
			.navigationTitle("WeSplit 💸")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView()
		}
    }
}
