//
//  CarouselItemView.swift
//  ArtArea
//
//  Created by Anton Petrov on 13.04.2022.
//

import SwiftUI

struct CarouselItem: Identifiable {
    var id = UUID().uuidString
    
    let name1: String
    let name2: String
    let backgroundColor = Color.random
}

struct CarouselItemView: View {
    
    let config: CarouselItem
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let minX = proxy.frame(in: .global).minX
                let horizontalInset = (UIScreen.main.bounds.size.width - proxy.size.width) / 2
                let realXOffset = (minX - horizontalInset) / 10
                let xOffset = abs(realXOffset) > 30 ? (realXOffset > 0 ? 30 : -30) : realXOffset
                Image(config.name1)
                    .resizable()
                    .scaledToFit()
                    .offset(x: xOffset)
                VStack {
                    HStack {
                        Text(config.id.prefix(5))
                            .padding(20)
                            .background(Color.blue.opacity(0.8))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text(config.name1)
                            .padding(20)
                            .background(Color.green.opacity(0.8))
                    }
                }
            }
            .background(config.backgroundColor)
            .cornerRadius(10)
            //.clipped()
        }
        .padding(.vertical, 20)
    }
}

struct CarouselDynamicItemView: View {
    
    let config: CarouselItem
    let carouselOffset: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let minX = proxy.frame(in: .global).minX
                let horizontalInset = (UIScreen.main.bounds.size.width - proxy.size.width) / 2
                let realXOffset = (minX - horizontalInset) * 0.15
                let symbol = realXOffset != 0 ? abs(realXOffset) / realXOffset : 1
                let xOffset = min(abs(realXOffset), 30) * symbol
                let yOffset = min(abs(realXOffset), 30) * symbol
                //let xOffset = abs(realXOffset) > 30 ? (realXOffset > 0 ? 30 : -30) : realXOffset
                Image(config.name1)
                    .resizable()
                    .scaledToFit()
                    .offset(x: xOffset)
                Image(config.name2)
                    .resizable()
                    .scaledToFit()
                    .offset(x: xOffset, y: -abs(xOffset))
                VStack {
//                    HStack {
//                        Text("\(xOffset)")
//                            .padding(20)
//                            .background(Color.blue.opacity(0.8))
//                        Spacer()
//                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text(config.name1)
                            .background(Color.green.opacity(0.8))
                    }
                }
            }
            .background(config.backgroundColor)
            .cornerRadius(10)
            //.clipped()
        }
        .padding(.vertical, 20)
    }
}
