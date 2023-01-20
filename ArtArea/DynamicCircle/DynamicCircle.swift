//
//  DynamicCircle.swift
//  ArtArea
//
//  Created by Anton Petrov on 04.11.2022.
//

import Foundation
import SwiftUI

struct DynamicCircle: View {
    @State private var show = false
    @State private var back = false
    
    @State var offset: CGSize = .zero
    @State var on: Bool = false
    
    let maxItems: Int = 10
    
    var body: some View {
        VStack {
            KashaView()
            //CircleView()
        }
    }
    
    func KashaView() -> some View {
        GeometryReader { proxy in
            ZStack() {
                TimelineView(.periodic(from: Date(), by: 4)) { context in
                    LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                        .hueRotation(.degrees(.random(in: 0...360)))
                        .animation(.easeInOut(duration: 3))
                        .mask(
                            Canvas { context, size in
                                context.addFilter(.alphaThreshold(min: 0.5, max: 1, color: .orange))
                                context.addFilter(.blur(radius: 30))
                                context.drawLayer { ctx in
                                    for index in 0...maxItems {
                                        if let resolvedView = context.resolveSymbol(id: index) {
                                            ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                        }
                                    }
                                }
                            } symbols: {
                                let itemW: CGFloat = 150
                                let itemH: CGFloat = 150

                                let middleX = (proxy.size.width / 2) - (itemW / 2)
                                let middleY = (proxy.size.height / 2) - (itemH / 2)

                                ForEach((0...maxItems), id: \.self) { i in
                                    let off = CGSize(
                                        width: .random(in: -middleX...middleX),
                                        height: .random(in: -middleY...middleY)
                                    )
                                    RoundedItem(offset: off)
                                        .frame(width: itemW, height: itemH)
                                        .tag(i)
                                }
                            }
                        )
                        .animation(.easeInOut(duration: 4))
                }
                //.blur(radius: 40)
                .background {
                    Color.blue
                }
                .ignoresSafeArea(.all)
                
//                VStack(alignment: .leading, spacing: 20) {
//                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                    HStack(alignment: .center, spacing: 20) {
//                        Image(systemName: "logo.xbox")
//                            .resizable()
//                            .frame(width: 200, height: 200, alignment: .center)
//                    }
//                    .frame(maxWidth: .infinity)
//
//
//                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
//                        .font(.callout)
//                        .foregroundColor(.white)
//
//
//                    Text("Habore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
//                        .font(.caption2)
//                        .foregroundColor(.white)
//
//                    Spacer()
//
//                    HStack(alignment: .center, spacing: 20) {
//                        Button("Log In") {
//
//                        }
//                        .frame(width: 200, height: 50, alignment: .center)
//                        .background(
//                            LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
//                        )
//                        .cornerRadius(5,antialiased: true)
//                    }
//                    .padding(.top, 50)
//                    .frame(maxWidth: .infinity)
//
//
//                }
//                .padding(20)
                
            }
        }
    }
    
    func CircleView() -> some View {
        Rectangle()
            .fill(LinearGradient(colors: [.blue, .yellow], startPoint: .top, endPoint: .bottom))
            .mask {
                Canvas { context, size in
                    //context.addFilter(.shadow(color: .blue, radius: 10))
                    context.addFilter(.alphaThreshold(min: 0.5, max: 1, color: .orange))
                    context.addFilter(.blur(radius: 30))
                    context.drawLayer { ctx in
                        for index in [1, 2, 3] {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball()
                        .tag(1)
                    Ball(offset: CGSize(width: -offset.width, height: -offset.height))
                        .tag(2)
                    Ball(offset: offset)
                        .tag(3)
                }
                //.frame(width: 300, height: 300, alignment: .center)
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    })
                    .onEnded({ value in
                        withAnimation(.interpolatingSpring(mass: 5, stiffness: 100, damping: 30)) {
                            offset = .zero
                        }
                    })
            )
    }
    
    func RoundedItem(offset: CGSize = .zero) -> some View {
        return RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.black)
            .offset(offset)
    }
    
    func Ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.black)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct DynamicCirclePreviews: PreviewProvider {
    static var previews: some View {
        DynamicCircle()
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.device)
    }
}

