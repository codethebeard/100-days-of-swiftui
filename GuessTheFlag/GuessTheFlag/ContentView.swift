//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael VanDyke on 11/6/21.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var alertTitle = ""
	@State private var score = 0
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: .white, location: 0.3),
				.init(color: .mint, location: 0.3),
				.init(color: .black, location: 1.5)
			], center: .top, startRadius: 80, endRadius: 700)
				.ignoresSafeArea()
			
			VStack(spacing: 40) {
				VStack {
					Text("Choose the correct flag for")
						.foregroundStyle(.primary)
						.font(.subheadline.weight(.bold).lowercaseSmallCaps())
						
					
					Text(countries[correctAnswer])
						.foregroundStyle(.mint)
						.font(.largeTitle.weight(.semibold))
			
				}
				
				
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						Image(countries[number])
							.renderingMode(.original)
							.shadow(color: .gray, radius: 1, x: 0, y: 0)
					}
					.alert(alertTitle, isPresented: $showingScore) {
						Button("Continue", action: askQuestion)
					} message: {
						Text("Your current score is \(score) points")
					}
				}
			}
		}
    }
	
	private func flagTapped(_ number: Int) {
		if number == correctAnswer {
			alertTitle = "Correct! 🚀"
			score += 1
		} else {
			alertTitle = "Wrong! 💩"
		}
		
		showingScore = true
	}
	
	private func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
