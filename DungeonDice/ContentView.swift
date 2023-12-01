//
//  ContentView.swift
//  DungeonDice
//
//  Created by David Veeneman on 11/22/23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var resultMessage = ""
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                titleView
                
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                ButtonLayout(resultMessage: $resultMessage)
                
            }
            .padding()
        }
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

