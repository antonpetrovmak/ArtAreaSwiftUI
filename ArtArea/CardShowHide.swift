//
//  CardShowHide.swift
//  ArtArea
//
//  Created by Anton Petrov on 27.09.2022.
//

import Foundation
import SwiftUI

struct CardShowHideView: View {
    @State private var showCard = false
    @State private var animateOnChange = false
    @State private var forceHideAnimateOnChange = false
    @GestureState private var someOffset: CGSize = .zero
    @State private var text = ""
    
    @State private var height: CGFloat = 0
    
    private enum Field: Int, CaseIterable {
        case textField
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            Button(action: {
                self.showCard.toggle()
                self.animateOnChange.toggle() // Only animate from this button
            }) {
                Image(systemName: "creditcard").font(.largeTitle)
            }
            VStack {
                HStack {
                    Spacer()
                    Text("Get the Card")
                    Spacer()
                    Button(action: {
                        self.showCard.toggle() // No animation (animateOnChange isn't changing)
                        self.forceHideAnimateOnChange.toggle()
                    }) {
                        Text("X").font(.body).padding(8)
                    }.background(Circle().stroke(Color.white))
                    
                }
                .foregroundColor(.white)
                
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 60, height: 50)
                    .foregroundColor(.white)
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
            .padding(.horizontal)
            .offset(x: showCard ? 0 : -400)
            .animation(.easeInOut(duration: 2), value: forceHideAnimateOnChange)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: animateOnChange)
        }
    }
}

struct CardShowHideView_Previews: PreviewProvider {
    static var previews: some View {
        CardShowHideView()
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.device)
            .previewDevice("iPhone 12")
    }
}
