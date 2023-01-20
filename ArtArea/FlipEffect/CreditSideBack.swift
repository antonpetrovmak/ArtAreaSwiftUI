//
//  CreditSideBack.swift
//  ArtArea
//
//  Created by Anton Petrov on 06.09.2022.
//

import SwiftUI

struct CreditSideBack: View {
    
    @State private var isCVVDisplay: Bool = false
    let cardData: CardData
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Wirex")
                        .font(.title2).bold()
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("VALID THRU")
                            .font(.caption)
                        Text(cardData.date)
                            .font(.system(size: 14))
                            .bold()
                            .onTapGesture {
                                
                            }
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 5) {
                        Text("CVV")
                            .font(.caption)
                        Text(isCVVDisplay ? cardData.cvv : "***")
                            .font(.system(size: 14))
                            .bold()
                            .frame(width: 50, height: 20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(2)
                            
                    }
                    .onTapGesture {
                        isCVVDisplay.toggle()
                    }
                }
            }
            .padding(15)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(cardData.color)
    }
    
}
