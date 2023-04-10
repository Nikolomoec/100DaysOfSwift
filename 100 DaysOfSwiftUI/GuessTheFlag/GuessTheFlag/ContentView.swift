//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nikita Kolomoec on 10.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var currentQuestion = 1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                Text("Question \(currentQuestion == 9 ? currentQuestion - 1 : currentQuestion)/8")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                VStack {
                    if currentQuestion != 9 {
                        VStack(spacing: 15) {
                            VStack {
                                Text("Tap the flag of")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                Text(countries[correctAnswer])
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            ForEach(0..<3) { num in
                                Button {
                                    currentQuestion += 1
                                    flagTapped(num)
                                } label: {
                                    Image(countries[num])
                                        .renderingMode(.original)
                                        .clipShape(Capsule())
                                        .shadow(radius: 10)
                                }
                            }
                        }
                    } else {
                        VStack(spacing: 15) {
                            Text("Game Over")
                                .font(.largeTitle)
                                .bold()
                            Text("Your score is \(currentScore)")
                                .font(.title2.bold())
                            Button {
                                currentQuestion = 1
                                currentScore = 0
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(red: 0.2, green: 0.2, blue: 0.45), Color(red: 0.76, green: 0.15, blue: 0.36)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(height: 60)
                                        .padding(.horizontal)
                                        .shadow(radius: 5)
                                    Text("Restart")
                                        .foregroundColor(.white)
                                        .font(.title3.bold())
                                }
                            }

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                Spacer()
                
                if currentQuestion != 9 {
                    Text("Score: \(currentScore)")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
            }
        }
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Good Job!"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong! That’s the flag of \(countries[number])"
        }
        isShowingScore.toggle()
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
