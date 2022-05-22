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
    @State private var questionNumber = 0
    
    @State private var currentAnswer: Int = 0
    @State private var isShowingScore = false
    @State private var isShowingSettings = false
   
    @StateObject var questions: Questions = Questions(size: .medium, levelRage: 2...5)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Question: \(questionNumber + 1) from \(questionnaireSize.rawValue)")
                    Spacer()
                    Text("Correct answers: \(score)")
                }
                Spacer()
                GameView(question: questions.scope[questionNumber], checkAnswer: updateScore)
                Spacer()
            }
            .padding()
            .navigationTitle("Multiplication")
            .toolbar {
                Button {
                    isShowingSettings = true
                } label: {
                    Text("Settings")
                }
            }
            .alert("Game over", isPresented: $isShowingScore) {
                Button("Ok") {
                    startNewGame()
                }
            } message: {
                Text("\(score) of \(questionnaireSize.rawValue) answers were correct. \nPress OK to continue")
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            startNewGame()
        } content: {
            SettingsView(save: setDifficulty)
        }
    }
    
    func updateScore(currentAnswer: Int) {
        if currentAnswer == questions.scope[questionNumber].answer {
            score += 1
        }
        if questionNumber < questionnaireSize.rawValue - 1 {
            questionNumber += 1
        } else {
            isShowingScore = true
        }
    }

    func startNewGame() {
        questions.generateQuestions(size: questionnaireSize, levelRage: minLevel...maxLevel)
        questionNumber = 0 // order can't help with first q
        score = 0
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
