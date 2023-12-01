//
//  ButtonLayoutView.swift
//  DungeonDice
//
//  Created by David Veeneman on 11/30/23.
//

import SwiftUI

struct ButtonLayout: View {
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
    
    // A PreferenceKey struct used to pass values up from child to parent Views
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
        
        
    }
    
    @State private var buttonsLeftOver = 0 // # of buttons in less-than-full row
    @Binding var resultMessage: String
    
    let horizontalPadding: CGFloat = 16 // default padding value
    let spacing: CGFloat = 0 // spacing between buttons
    let buttonWidth: CGFloat = 102

    var body: some View {
        VStack {
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
        .overlay {
            GeometryReader { geo in
                Color.clear
                    .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
            }
        }
        .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
            arrangeGridItems(deviceWidth: deviceWidth)
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
#Preview {
    ButtonLayout(resultMessage: .constant(""))
}
