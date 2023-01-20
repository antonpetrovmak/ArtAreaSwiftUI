//
//  CreditSideFront.swift
//  ArtArea
//
//  Created by Anton Petrov on 06.09.2022.
//

import SwiftUI

struct CreditSideFront: View {
    
    let cardData: CardData
    
    @State var isCopied: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Wirex")
                        .font(.title2).bold()
                    Spacer()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("CARD NUMBER")
                        .font(.caption)
                    HStack {
                        if isCopied {
                            Text("Copied")
                                .font(.system(size: 14))
                        } else {
                            Text(cardData.number)
                                .font(.system(size: 14))
                                .bold()
                                .onTapGesture {
                                    isCopied.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        isCopied.toggle()
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, idealHeight: 30)
                    .background(isCopied ? Color.green : .clear)
                    
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("CARDHOLDER")
                        .font(.caption)
                    Text(cardData.cardholder)
                        .font(.system(size: 14))
                        .bold()
                        .onTapGesture {
                            
                        }
                }
                
                HStack {
                    Spacer()
                    Text(cardData.provider)
                        .foregroundColor(.white)
                        .font(.title2).bold()
                        .italic()
                }

            }
            .padding(15)
        }
        .animation(nil)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(cardData.color)
    }
    
}
