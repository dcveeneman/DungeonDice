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
    @State private var buttonsLeftOver = 0 // # of buttons in less-than-full row
    
    let horizontalPadding: CGFloat = 16 // default padding value
    let spacing: CGFloat = 0 // between buttons
    let buttonWidth: CGFloat = 102
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                titleView
                
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach (Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                        
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
            }
            .padding()
            .onChange(of: geo.size.width, { oldValue, newValue in
                arrangeGridItems(deviceWidth: geo.size.width)
            })
            .onAppear {
                arrangeGridItems(deviceWidth: geo.size.width)
            }
        }
    }
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        // Calculate width of screen, net of left and right padding
        var screenWidth = deviceWidth - horizontalPadding * 2
        
        // Adjust for spacing between items
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        // Calculate numOfButtonsPerRow as an Int
        let numOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numOfButtonsPerRow
    }
}

extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
}

#Preview {
    ContentView()
}

