//
//  CarouselExample.swift
//  ArtArea
//
//  Created by Anton Petrov on 03.04.2022.
//

import SwiftUI

struct CarouselExample: View {
    
    let items: [CarouselItem] = [
        .init(name1: "p1_1", name2: "p1_2"),
        .init(name1: "p2_1", name2: "p2_2"),
        .init(name1: "p3_1", name2: "p3_2"),
        .init(name1: "p3_1", name2: "p3_2"),
        .init(name1: "p2_1", name2: "p2_2"),
        .init(name1: "p1_1", name2: "p1_2")
    ]
    
    @State private var index: Int = 0
    @State private var spacing: CGFloat = 20
    @State private var trailingSpace: CGFloat = 40
    @State private var degrees: CGFloat = 0
    
    var body: some View {
        VStack {
            panelView
            Divider()
            //            Carousel(spacing: spacing,
            //                     trailingSpace: trailingSpace,
            //                     index: $index,
            //                     items: items,
            //                     content: { CarouselItemView(config: $0) })
            //                .frame(height: 200)
            //            Divider()
            Carousel(spacing: spacing,
                     trailingSpace: trailingSpace,
                     index: $index,
                     items: items,
                     content: { config, offset in
                CarouselDynamicItemView(config: config, carouselOffset: offset)
            })
            .frame(height: 200)
            Divider()
            HStack {
                ForEach(0...(items.count - 1), id: \.self) { i in
                    Button("#\(i)") {
                        self.index = i
                    }
                    .foregroundColor(i == index ? .black : .blue)
                }
            }
            Spacer()
        }
    }
    
    private var panelView: some View {
        VStack {
            Text("Spacing \(Int(spacing))px")
            Slider(value: $spacing, in: 0...200)
            
            Text("Trailing Space \(Int(trailingSpace))px")
            Slider(value: $trailingSpace, in: 0...200)
            
            Text("degrees \(Int(degrees))")
            Slider(value: $degrees, in: -360...360)
        }
        .padding(20)
    }
}

struct CarouselExample_Previews: PreviewProvider {
    static var previews: some View {
        CarouselExample()
            .previewDevice("iPhone 12")
    }
}
