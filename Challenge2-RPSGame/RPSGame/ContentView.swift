//
//  ContentView.swift
//  RPSGame
//
//  Created by yomizzz on 2022/2/2.
//

/*
 Each turn of the game the app will randomly pick either rock, paper, or scissors.
 Each turn the app will alternate between prompting the player to win or lose.
 The player must then tap the correct move to win or lose the game.
 If they are correct they score a point; otherwise they lose a point.
 The game ends after 10 questions, at which point their score is shown.
 
 Start with an App template, then create a property to store the three possible moves: rock, paper, and scissors.
 You’ll need to create two @State properties to store the app’s current choice and whether the player should win or lose.
 You can use Int.random(in:) to select a random move. You can use it for whether the player should win too if you want, but there’s an even easier choice: Bool.random() is randomly true or false. After the initial value, use toggle() between rounds so it’s always changing.
 Create a VStack showing the player’s score, the app’s move, and whether the player should win or lose. You can use if shouldWin to return one of two different text views.
 The important part is making three buttons that respond to the player’s move: Rock, Paper, or Scissors.
 Use the font() modifier to adjust the size of your text. If you’re using emoji for the three moves, they also scale. Tip: You can ask for very large system fonts using .font(.system(size: 200)) – they’ll be a fixed size, but at least you can make sure they are nice and big!
 */

import SwiftUI

struct ContentView: View {
    @State private var showChoice = ["✌️", "👊", "🖐"]
    @State private var isWin = Bool.random()
    @State private var score = 0
    @State private var computerChoice = ""
    @State private var result = ""
    @State private var gameEnd = false
    @State private var playTime = 0
    
    func gestTapped(_ number: Int) {
        if isWin == true {
            if number == 0 {
                computerChoice = "🖐"
            } else if number == 1 {
                computerChoice = "✌️"
            } else {
                computerChoice = "👊"
            }
            
            result = "Win"
            score  += 1
            
        } else {
            if number == 0 {
                computerChoice = "👊"
            } else if number == 1 {
                computerChoice = "🖐"
            } else {
                computerChoice = "✌️"
            }
            
            result = "Lose"
        }
        
        isWin.toggle()
        playTime += 1
        
        if playTime >= 10 {
            gameEnd = true
        }
    }
    
    func reset() {
        gameEnd = false
        playTime = 0
        result = ""
        computerChoice = ""
        score = 0
        isWin = Bool.random()
    }
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 300, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                
                VStack {
                    Text("\(result)")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Score: \(score)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Spacer()
                
                Text("Computer Choice:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(computerChoice)")
                    .font(.system(size: 50))
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Choose one:")
                            .font(.title.bold())
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            gestTapped(number)
                        } label: {
                            Text(showChoice[number])
                                .font(.system(size: 100))
                        }
                    }
                }
                
                .padding()
            }
            
            .alert("Game Over", isPresented: $gameEnd) {
                Button("Restart", action: reset)
            } message: {
                Text("Congratuations! your scores is \(score).")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
