//
//  Carousel.swift
//  ArtArea
//
//  Created by Anton Petrov on 03.04.2022.
//

import SwiftUI

struct Carousel<Content: View, T: Identifiable>: View {
    
    typealias ContentHandler = (_ config: T,_ offset: CGFloat) -> Content
    var content: ContentHandler
    var items: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    @GestureState private var offset: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var isDragging: Bool = false
    
    init(spacing: CGFloat = 15,
         trailingSpace: CGFloat = 100,
         index: Binding<Int>,
         items: [T],
         @ViewBuilder content: @escaping ContentHandler) {
        self.spacing = spacing
        self.trailingSpace = trailingSpace * 2
        self.content = content
        self.items = items
        self._index = index
    }
    
    var body: some View {
        GeometryReader { proxy in
            let itemWidth = (proxy.size.width - trailingSpace + spacing)
            
            LazyHStack(alignment: .center, spacing: spacing) {
                ForEach(items) { item in
                    content(item, offset)
                        .frame(width: proxy.size.width - trailingSpace,
                               height: proxy.size.height)
                }
            }
            .padding(.horizontal, trailingSpace / 2)
            .offset(x: (CGFloat(index) * -itemWidth) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, trans in
                        print("update value: \(value.translation.width)")
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        print("end value: \(value.translation.width)")
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / itemWidth
                        let roundIndex = Int(progress.rounded())
                        
                        index = max(min(index + roundIndex, items.count - 1), 0)
                    })
            )
            .animation(.spring(), value: offset == 0)
            .animation(.spring(), value: index)
        }
    }
    
}
