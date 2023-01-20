//
//  CardData.swift
//  ArtArea
//
//  Created by Anton Petrov on 24.10.2022.
//

import SwiftUI

struct CardData: Identifiable {
    var id: UUID = UUID()
    
    let number: String
    let cardholder: String
    let provider: String
    let date: String
    let cvv: String
    let color: Color = .random
}

extension CardData {
    static let `default`: CardData =  CardData(
        number: "4242 4242 4242 4242",
        cardholder: "ANTON PETROV",
        provider: "VISA",
        date: "07/35",
        cvv: "453"
    )
    
    static let cards: [CardData] = [
        CardData.default,
        CardData(
            number: "2585 7494 7709 7773",
            cardholder: "Jon Ho",
            provider: "VISA",
            date: "08/15",
            cvv: "942"
        ),
        CardData(
            number: "11234 4321 5432 5678",
            cardholder: "Lok Dorra",
            provider: "MASTERCARD",
            date: "07/35",
            cvv: "74"
        )
    ]
}
