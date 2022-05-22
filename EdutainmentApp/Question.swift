//
//  Question.swift
//  EdutainmentApp
//
//  Created by Alex Po on 17.05.2022.
//

import Foundation

struct Question {
    let leftOperand: Int
    let rightOperand: Int
    let answer: Int
    
    init(multiply left: Int, by right: Int) {
        leftOperand = left
        rightOperand = right
        answer = left * right
    }
    static var example = Question(multiply: 5, by: 5)
}

class Questions: ObservableObject {
    @Published var scope: [Question]
    static var example = Question(multiply: 11, by: 12)
    
    init(size: Questionnaire, levelRage: ClosedRange<Int>) {
        scope = [Question]()
        generateQuestions(size: size, levelRage: levelRage)
    }
    
    func generateQuestions(size: Questionnaire, levelRage: ClosedRange<Int>) {
        scope.removeAll()
        for _ in 1...size.rawValue {
            let question = Question(multiply: Int.random(in: levelRage), by: Int.random(in: levelRage))
            scope.append(question)
        }
    }
}
