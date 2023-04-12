//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nikita Kolomoec on 11.04.2023.
//

enum GameElements: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

import SwiftUI

struct ContentView: View {
    @State private var winLose = false
    @State private var gameStarted = false
    @State private var submitTapped = false
    @State private var finalText = ""
    @State private var score = 0
    @State private var questionNum = 0
    
    @State private var playerElementSelected = Array(repeating: false, count: 3)
    @State private var botElementSelected = Array(repeating: false, count: 3)
    @State private var selectedPlayerElementIndex: Int?
    @State private var selectedBotElementIndex: Int?
    
    @State private var previousIndex: Int?
    
    var body: some View {
        ZStack {
            // Background
            RadialGradient(stops: [
                .init(color: Color.red, location: 0.3),
                .init(color: Color.purple, location: 0.3)
            ], center: .bottomTrailing, startRadius: 700, endRadius: 600)
                .ignoresSafeArea()
            
            if questionNum <= 10 {
                VStack {
                    // MARK: - BOT
                    HStack {
                        Text("Bot Picked")
                            .titleText(padding: .leading)
                        Spacer()
                        // Question Number
                        VStack(spacing: 0) {
                            Text("\(questionNum)/10")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.white)
                                .frame(width: 75, height: 8)
                        }
                        .padding(.trailing)
                    }
                    HStack(spacing: 20) {
                        ForEach(Array(GameElements.allCases.enumerated()), id: \.element) { index, element in
                            GamePickView(name: element.rawValue, isSelected: botElementSelected[index])
                        }
                    }
                    if gameStarted {
                        Group {
                            Text("You need to ") +
                            Text(winLose ? "Win" : "Lose")
                                .foregroundColor(winLose ? .green : .red)
                        }
                        .titleText()
                        Spacer()
                        if !playerElementSelected.allSatisfy({ $0 == false }) && !botElementSelected.allSatisfy({ $0 == false }) && !submitTapped {
                            Button {
                                submitTapped = true
                                submit()
                            } label: {
                                CustomButton(name: "Submit")
                            }
                        } else if submitTapped {
                            VStack {
                                
                                Text(finalText)
                                    .titleText(padding: .bottom)
                                
                                Button {
                                    submitTapped = false
                                    nextRound()
                                } label: {
                                    CustomButton(name: questionNum == 10 ? "Finish Game" : "Next Round")
                                }
                            }
                            
                        } else {
                            Text("Pick Your Element...")
                                .titleText(font: .title.bold())
                        }
                    } else {
                        Spacer()
                        Button {
                            gameStarted = true
                            nextRound()
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(LinearGradient(colors: [Color.red, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 15)
                                Circle()
                                    .foregroundColor(.secondary)
                                    .shadow(radius: 10)
                                Text("Start")
                                    .titleText()
                            }
                            .frame(width: 250)
                        }
                        Spacer()
                    }
                    
                    
                    // MARK: - Player
                    HStack(spacing: 20) {
                        ForEach(Array(GameElements.allCases.enumerated()), id: \.element) { index, element in
                            Button {
                                if previousIndex != index && gameStarted {
                                    playerElementSelected[index] = true
                                    if let previousIndex = previousIndex {
                                        playerElementSelected[previousIndex] = false
                                    }
                                    selectedPlayerElementIndex = index
                                    previousIndex = index
                                }
                            } label: {
                                GamePickView(name: element.rawValue, isSelected: playerElementSelected[index])
                            }
                            .disabled(submitTapped)
                        }
                    }
                    HStack {
                        VStack(spacing: 0) {
                            Text("Score \(score)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.white)
                                .frame(width: 120, height: 8)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        Text("You Picked")
                            .titleText(padding: .trailing)
                    }
                }
            } else {
                VStack {
                    Spacer()
                    ZStack {
                        VStack {
                            Text("Game Over")
                                .titleText()
                            Text("Your Score: \(score)")
                                .titleText(font: .title3.bold())
                        }
                    }
                    .padding(35)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.secondary)
                    )
                    Button {
                        restart()
                    } label: {
                        CustomButton(name: "Restart")
                    }

                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Functuanality
    func nextRound() {
        winLose = Bool.random()
        for i in 0...2 {
            botElementSelected[i] = false
            playerElementSelected[i] = false
        }
        let randomElement = Int.random(in: 0...2)
        selectedBotElementIndex = randomElement
        botElementSelected[selectedBotElementIndex!] = true
        selectedPlayerElementIndex = nil
        previousIndex = nil
        submitTapped = false
        questionNum += 1
    }
    func submit() {
        let bot = selectedBotElementIndex
        let player = selectedPlayerElementIndex
        
        if bot == 0 && player == 0 && !winLose || bot == 0 && player == 0 && winLose || bot == 1 && player == 1 && !winLose || bot == 1 && player == 1 && winLose || bot == 2 && player == 2 && !winLose || bot == 2 && player == 2 && winLose {
            finalText = "Tie!"
        } else if bot == 0 && player == 1 && winLose || bot == 0 && player == 2 && !winLose || bot == 1 && player == 0 && !winLose || bot == 1 && player == 2 && winLose || bot == 2 && player == 0 && winLose || bot == 2 && player == 1 && winLose {
            score += 1
            finalText = "You Win!"
        } else {
            score -= 1
            finalText = "You Lose!"
        }
    }
    func restart() {
        score = 0
        questionNum = 0
        winLose = Bool.random()
        submitTapped = false
        previousIndex = nil
        gameStarted = true
        selectedBotElementIndex = nil
        selectedPlayerElementIndex = nil
        botElementSelected = botElementSelected.map({ _ in false })
        playerElementSelected = playerElementSelected.map({ _ in false })
        gameStarted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GamePickView: View {
    var name: String
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 100)
                .foregroundColor(isSelected ? .primary : .secondary)
            VStack {
                Image(name.lowercased())
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 5)
                Text(name)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        }
    }
}

struct TitleText: ViewModifier {
    var padding: Edge.Set?
    var font: Font?
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .padding(padding == nil ? 0 : 30)
    }
}

extension View {
    func titleText(padding: Edge.Set? = nil, font: Font? = .largeTitle.bold()) -> some View {
        modifier(TitleText(padding: padding, font: font))
    }
}

struct CustomButton: View {
    var name: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(LinearGradient(colors: [Color.red, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 15)
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.secondary)
                .shadow(radius: 10)
            Text(name)
                .titleText(font: .title2.bold())
        }
        .frame(height: 60)
        .padding()
        .padding(.horizontal)
    }
}
