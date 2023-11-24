//
//  ContentView.swift
//  DungeonDice
//
//  Created by David Veeneman on 11/22/23.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
    
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(height: 150)
            
            Spacer()
            
            ForEach (Dice.allCases, id: \.self) { dice in
                Button("\(dice.rawValue)-sided") {
                    resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
