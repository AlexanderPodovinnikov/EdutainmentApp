//
//  SettingsView.swift
//  EdutainmentApp
//
//  Created by Alex Po on 17.05.2022.
//

import SwiftUI

struct SettingsView: View {
    let maxLevel = 12
    @State private var numberOfQuestions: Questionnaire = .small
    @State private var level: Int = 5
    var saveSettings: (Questionnaire, Int) -> Void
    
    init(save: @escaping (Questionnaire, Int) -> Void) {
        saveSettings = save
    }
    
    var body: some View {
        Form {
            Text("Your difficulty settings:")
                .font(.title)
                .padding(.bottom)
            Section("Number of questions") {
                Picker("Number of questions", selection: $numberOfQuestions) {
                    ForEach(Questionnaire.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: numberOfQuestions) { newValue in
                    saveSettings(newValue, level)
                }
            }
  
            Section("Level") {
                Picker("Level:", selection: $level) {
                    ForEach(2...maxLevel, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: level) { newValue in
                    saveSettings(numberOfQuestions, newValue)
                }
            }
            .padding()
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView { q, i in
            
        }
    }
}
