//
//  ContentView.swift
//  Edutainment
//
//  Created by yomizzz on 2022/2/21.
//

import SwiftUI

struct Question {
    var data: String
    var answer: Int
}

struct ContentView: View {
    @State private var isGameActive = false
    @State private var multipTable = 5
    @State private var questionNum = 5
    @State private var currentQuestionIndex = 0
    @State private var questions : Array<Question> = []
    @State private var userInputted = ""
    @State private var userScore = 0
    @State private var isGameComplete = false
    @State private var alertMessage = ""
    let questionNums = [5, 10, 20]
    
    func generateQuestion() {
        questions.removeAll()
        
        for _ in 1...questionNum {
            let num1 = Int.random(in: 2...multipTable)
            let num2 = Int.random(in: 2...multipTable)
            let question = Question(data: "\(num1) X \(num2)", answer:  num1 * num2)
            questions.append(question)
        }
    }
    
    func checkAnswer(userAnswer: Int, answer: Int) {
        if userAnswer == answer {
            userScore += 1
        }
        
        userInputted = ""
        
        if currentQuestionIndex < questionNum - 1 {
            currentQuestionIndex += 1
        } else {
            alertMessage = "Your score is \(userScore)"
            isGameComplete = true
        }
    }
    
    
    func gameRestart() {
        isGameActive = false
        userInputted = ""
        userScore = 0
        alertMessage = ""
        currentQuestionIndex = 0
    }
    
    var body: some View {
        if isGameActive {
            VStack {
                Text("User Score: \(userScore)")
                    .font(.title)
                    .padding()
                
                Text("\(questions[currentQuestionIndex].data)")
                    .font(.title)
                    .padding()
                
                TextField("Enter your answer", text: $userInputted)
                    .padding()
                
                Spacer()
                Button("Enter") {
                    checkAnswer(userAnswer: Int(userInputted) ?? 0, answer: questions[currentQuestionIndex].answer)
                }
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 50, maxHeight: 50, alignment: .center)
                .background(.red)
                .foregroundColor(.white)
                .alert(isPresented: $isGameComplete) {
                    Alert(title: Text(alertMessage), message: Text("Game Over"), primaryButton: .destructive(Text("Okay")){
                        gameRestart()
                    }, secondaryButton: .cancel())
                }
            }
        } else {
            NavigationView {
                Form {
                    Section {
                        Stepper("\(multipTable)", value: $multipTable, in: 2...12)
                        
                    } header: {
                        Text("Multiplication Table")
                    }
                    
                    Section {
                        Picker("Numbers of Questions", selection: $questionNum) {
                            ForEach(questionNums, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Numbers of Questions")
                    }
                    
                    Section {
                        Text("Multiplication Table:        \(multipTable)")
                        Text("Number of Questions:     \(questionNum)")
                    }
                    
                    Button("Start Game") {
                        generateQuestion()
                        isGameActive.toggle()
                    }
                    .frame(width: 300, height: 50, alignment: .center)
                    .font(.title)
                    .foregroundColor(.red)
                    
                }
                .navigationTitle("Edutainment")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
