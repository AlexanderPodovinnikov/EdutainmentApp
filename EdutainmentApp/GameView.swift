//
//  GameView.swift
//  EdutainmentApp
//
//  Created by Alex Po on 18.05.2022.
//

import SwiftUI

struct AnswerView: View {
    var answer: Int
    var answerDigits: [Int?]
    @Binding var rotationAmount: Double
    
    init(_ answer: Int, _ animationAmount: Binding<Double>) {
        self.answer = answer
        _rotationAmount = animationAmount
        
        if answer == 0 {
            answerDigits = [nil, nil, nil]
            return
        }
        
        if answer < 10 {
            answerDigits = [nil, nil, answer]
        } else if answer < 100 {
            answerDigits = [nil, answer / 10, answer % 10]
        } else {
            answerDigits = [answer / 100, answer % 100 / 10, answer % 100 % 10]
        }
    }
    
    var body: some View {
        Group {
            ForEach(answerDigits, id: \.self) { digit in
                if let digit = digit {
                    Image(systemName: "\(digit).square.fill")
//                        .onAppear(perform: {rotationAmount += .degrees(360)})
                }
            }
            .rotation3DEffect(.degrees(rotationAmount), axis: (x: 1.0, y: 0.0, z: 0.0))
//            .animation(.easeOut, value: rotationAmount)
        }
    }
}

struct GameView: View {
    var terms: [String]
    @State private var answer: Int = 0
    
    var question: Question
    
    var test: (Int) -> Void
    
    @State var rotationAmount: Double = 0
    
    init(question: Question, checkAnswer: @escaping (Int) -> Void) {
        
        test = checkAnswer
        
        self.question = question 
        
       terms = ["\(question.leftOperand)", "x", "\(question.rightOperand)", "equal"]
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<terms.count, id:\.self) {
                    Image(systemName: "\(terms[$0]).square")
                }
                AnswerView(answer, $rotationAmount)
            }
            .font(.system(size: 40))
            .padding(.bottom)
            VStack {
                VStack {
                    ForEach(0...2, id: \.self) {row in
                        HStack {
                            ForEach(0...2, id: \.self) { col in
                                let key = row * 3 + col
                                Button {
                                    addDigit(key)
                                    withAnimation(.easeOut) {
                                        rotationAmount += 360
                                    }
                                }label: {
                                    Image(systemName: "\(key).square")
                                }
                            }
                        }
                    }
                }
                HStack {
                    Button {
                        addDigit(9)
                        withAnimation(.easeOut) {
                            rotationAmount += 360
                        }
                    } label: {
                        Image(systemName: "9.square")
                    }
                    Button {
                        answer = answer / 10
                        withAnimation(.easeOut) {
                            rotationAmount -= 360
                        }
                        
                    } label: {
                        Image(systemName: "chevron.forward.square")
                    }
                    Button {
                        
                        test(answer)
                        answer = 0
                            rotationAmount = 0
                    }label: {
                        Image(systemName: "arrow.down.square")
                    }
                }
            }
            .font(.system(size: 70))
        }
    }
    func addDigit(_ digit: Int) {
        if digit >= 0 && digit < 10 {
            let newValue = answer * 10 + digit
            if newValue < 1000 {
                answer = newValue
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(question: Question.example) { Int in

        }
    }
}
