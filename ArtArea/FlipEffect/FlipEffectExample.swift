//
//  FlipEffectExample.swift
//  ArtArea
//
//  Created by Anton Petrov on 06.09.2022.
//

import SwiftUI

struct FlipEffectExample: View {
    
    @State private var flipped = false
    @State private var selectedIndex: Int = 1
    @State private var carouselIndex: Int = 0
    private var items: [CardData] = CardData.cards

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedIndex) {
                Text("One")
                Text("Carousel")
            }
            .pickerStyle(.segmented)
            .padding()
            
            if selectedIndex == 0 {
                VStack {
                    Divider()
                    CreditCardView(.default)
                        .frame(width: 195, height: 280)
                    Divider()
                }
            } else if selectedIndex == 1 {
                Carousel(spacing: 20,
                         trailingSpace: 100,
                         index: $carouselIndex,
                         items: items,
                         content: { config, offset in
                    CreditCardView(config)
                        .frame(width: 195, height: 280)
                })
                .frame(height: 280)
                .padding(.top, 50)
                
                HStack { Spacer () }
                    .frame(height: 100)
                    .background(Color.blue)
            }
            
            Spacer()
        }
    }
    
    private func CreditCardView(_ cardData: CardData) -> some View {
        CreditCard(
            sideView1: CreditSideFront(cardData: cardData),
            sideView2: CreditSideBack(cardData: cardData)
        )
    }
}

struct FlipEffectExample_Previews: PreviewProvider {
    static var previews: some View {
        FlipEffectExample()
            .previewDevice("iPhone 12")
    }
}
