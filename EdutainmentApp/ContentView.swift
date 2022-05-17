//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Alex Po on 16.05.2022.
//

import SwiftUI

enum Questionnaire: Int, CaseIterable {
    case small = 5, medium = 10, large = 20
}

struct ContentView: View {
    
    let minLevel = 2
    @State private var maxLevel = 5
    @State private var questionnaireSize = Questionnaire.medium
    
    @State private var score = 0
    @State private var currentQuestion = 0
    @State private var currentAnswer: Int?
    @State private var isShowingScore = false
    
    @FocusState private var inputIsFocused: Bool
    
    var questions: Questions
    
    init() {
        questions = Questions(size: .medium, levelRage: minLevel...5)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Question: \(currentQuestion + 1) from \(questionnaireSize.rawValue)")
                    Spacer()
                    Text("Correct answers: \(score)")
                }
                .padding(.bottom)
                
                Text("What is \(questions.scope[currentQuestion].leftOperand) x \(questions.scope[currentQuestion].rightOperand)?")
                    .font(.title)
                    .padding(.bottom)
                Text("The answer is:")
                    .font(.title2)
                    
                Section {
                    TextField("Enter your answer", value: $currentAnswer, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                }
                    .padding()
                Button("Next") {
                    if currentAnswer == questions.scope[currentQuestion].answer {
                        score += 1
                    }
                    inputIsFocused = false
                    currentAnswer = nil
                    
                    if currentQuestion < questionnaireSize.rawValue - 1 {
                        currentQuestion += 1
                    } else {
                        isShowingScore = true

                    }
                }
                .font(.title)
                NavigationLink {
                    SettingsView(save: setDifficulty)
                } label: {
                    Text("Settings ->")
                }
                .font(.title2)
                .padding()
                .onChange(of: questionnaireSize) { _ in
                    startNewGame()
                }
                .onChange(of: maxLevel) { _ in
                    startNewGame()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Multiplication")
            .alert("Game over", isPresented: $isShowingScore) {
                Button("Ok") {
                    startNewGame()
                }
            } message: {
                Text("\(score) of \(questionnaireSize.rawValue) your answers were coorect. \nPress OK to continue")
            }
        }
    }
    
    func startNewGame() {
        currentQuestion = 0
        score = 0
        questions.generateQuestions(size: questionnaireSize, levelRage: minLevel...maxLevel)
    }
    
    func setDifficulty(size: Questionnaire, level: Int) {
        questionnaireSize = size
        maxLevel = level
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
