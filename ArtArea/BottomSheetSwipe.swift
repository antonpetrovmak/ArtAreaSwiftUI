//
//  BottomSheetSwipe.swift
//  ArtArea
//
//  Created by Anton Petrov on 20.09.2022.
//

import Foundation
import SwiftUI

struct BottomSheetSwipe: View {
    @GestureState private var menuOffset: CGSize = .zero
    @State private var currentMenuY: CGFloat = 0
    @State private var change = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            Divider()
            VStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .overlay(Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                        .offset(x: 0, y: -20))
                    .offset(x: 0, y: -50)
                HStack { Spacer() }
                Spacer()
            }
            .frame(height: 200)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.green))
            .offset(x: 0, y: currentMenuY + menuOffset.height)
            .gesture(
                DragGesture()
                    .updating($menuOffset, body: { (value, menuOffset, transaction) in
                        print("Chnage \(value.translation)")
                        if value.translation.height <= -200 {
                            menuOffset = .init(width: 0, height: 0)
                        } else {
                            menuOffset = value.translation
                        }
                    })
                    .onEnded({ value in
                        print("End \(value)")
                        if value.translation.height > -100 {
                            self.currentMenuY = 200 // collapse
                        } else {
                            self.currentMenuY = 0 // expanded
                        }
                    })
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.4))
            
            Divider()
            
        }
        .font(.title)
    }
}


struct BottomSheetSwipe_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetSwipe()
            .previewDevice("iPhone 12")
    }
}

