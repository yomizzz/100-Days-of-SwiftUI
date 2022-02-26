//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by yomizzz on 2022/1/22.
//

import SwiftUI

struct FlagImage: View {
    var countries: Array<String>
    var number: Int
    
    var body: some View {
        Image(countries[number])
            .renderingMode(.original) // 使图片显示自身的颜色
            .clipShape(Capsule()) // 改按钮形状
            .shadow(radius: 5) // 加阴影
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() // 洗牌
    @State private var correctAnswer = Int.random(in: 0...2) // 从0， 1， 2中随机选出一个数字，作为数组里正确地图的下标
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0 // 显示用户分数
    @State private var chosenNumber = 0 // 当选择错误时，用于显示正确答案
    @State private var showTime = 0 // 显示游戏次数
    @State private var gameEnd = false // 显示游戏是否结束
    @State private var animationAmounts = [0.0, 0.0, 0.0]
    @State private var animationOpacity = [1.0, 1.0, 1.0]
    @State private var animationSize = [1.0, 1.0, 1.0]
    
    func flagtapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
            chosenNumber = number
        }
        
        //showingScore = true
        showTime += 1
        
        if showTime < 8 {
            showingScore = true
        } else {
            gameEnd = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationOpacity = [1.0, 1.0, 1.0]
        animationSize = [1.0, 1.0, 1.0]
    }
    
    func reset() {
        gameEnd = false
        userScore = 0
        showTime = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack { // 先出现的 View 在最下方
            //LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess th Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            //.foregroundColor(.white)
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            //.foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagtapped(number)
                            
                            withAnimation(.easeIn(duration: 1)) {
                                animationAmounts[number] += 360
                                for num in 0..<3 {
                                    animationOpacity[num] = ( num == number ? 1.0 : 0.25)
                                    animationSize[num] = ( num == number ? 1.0 : 2.0)
                                }
                            }
                            
                        } label: {
                            
                            FlagImage(countries: countries, number: number)
                            /*
                            Image(countries[number])
                                .renderingMode(.original) // 使图片显示自身的颜色
                                .clipShape(Capsule()) // 改按钮形状
                                .shadow(radius: 5) // 加阴影
                             */
                        }
                        .rotation3DEffect(.degrees(animationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(animationOpacity[number])
                        .scaleEffect(animationSize[number])
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                
                .padding()
            }
            
            .alert("Game Over", isPresented: $gameEnd) {
                Button("Restart", action: reset)
            } message: {
                Text("Congratulations! Your score is \(userScore)")
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                if scoreTitle == "Correct" {
                    Text("Your score is \(userScore)")
                } else {
                    Text("That's the flag of \(countries[chosenNumber])")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
