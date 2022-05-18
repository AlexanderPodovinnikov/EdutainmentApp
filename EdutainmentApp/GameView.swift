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
    
    
    init(_ answer: Int) {
        self.answer = answer
        
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
                }
            }
        }
    }
}

struct GameView: View {
    var terms = ["2", "x", "2", "equal"]
    @State private var answer: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<terms.count, id:\.self) {
                    Image(systemName: "\(terms[$0]).square")
                }
                AnswerView(answer)
            }
            .font(.system(size: 40))
            .padding(.bottom)
            VStack {
                HStack {
                    ForEach(0...2, id: \.self) { key in
                        Button {
                            addDigit(key)
                        } label: {
                            Image(systemName: "\(key).square")
                        }
                    }
                }
                HStack {
                    ForEach(3...5, id: \.self) { key in
                        Button {
                            addDigit(key)
                        } label: {
                            Image(systemName: "\(key).square")
                        }
                    }
                }
                HStack {
                    ForEach(6...8, id: \.self) { key in
                        Button {
                            addDigit(key)
                        } label: {
                            Image(systemName: "\(key).square")
                        }
                    }
                }
                HStack {
                    Button {
                        addDigit(9)
                    } label: {
                        Image(systemName: "9.square")
                    }
                    Button {
                        answer = answer / 10
                        
                    } label: {
                        Image(systemName: "chevron.forward.square")
                    }
                    Button {
                        
                        // save as current answer and check it
                        
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
        GameView()
    }
}
