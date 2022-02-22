//
//  ContentView.swift
//  secondProject
//
//  Created by Максим Клочков on 22.02.2022.
//

import SwiftUI

struct ContentView: View {

    @State private var countries = ["USA", "UK", "Sweden", "Russia", "Greece", "Germany", "Canada", "Brazil", "Bangladesh", "Argentina" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var score = 0
    @State private var showInScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Выберите флаг:")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0..<4) { number in
                    Button(action: {
                        self.flaggTapped(number)
                        self.showInScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 230, height: 125)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                    }
                }

                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                Spacer()
            }
        }.alert(isPresented: $showInScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }


    }

    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...3)
    }

    func flaggTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
