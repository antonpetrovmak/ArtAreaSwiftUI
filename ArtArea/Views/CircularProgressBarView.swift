//
//  CircularProgressBarView.swift
//  Wirex
//
//  Created by Oleksandr Borysenko on 30.11.2021.
//  Copyright © 2021 Wirex Limited. All rights reserved.
//

import SwiftUI

struct WXCircularProgress<Content: View>: View {
    let outerPercent: CGFloat
    let innerPercent: CGFloat
    let action: () -> Void
    let content: Content
    
    @State private var _outerPercent: CGFloat = 0
    @State private var _innerPercent: CGFloat = 0

    var body: some View {
        ZStack(alignment: .center) {
            circleView
                .onTapGesture {
                    action()
                }
            VStack(alignment: .center) {
                Spacer()
                content
            }
        }
        .onAppear {
            self._outerPercent = outerPercent
            self._innerPercent = innerPercent
        }
        .padding(.horizontal, 54)
    }

    var circleView: some View {
        ZStack {
            if (0...1).contains(outerPercent) {
                outerView
            }
            if (0...1).contains(innerPercent) {
                innerView
            }
        }
    }

    var outerView: some View {
        ZStack {
            WXArc(type: .outer, percent: 1)
                .foregroundColor(.gray)
            WXArc(type: .outer, percent: _outerPercent)
                .foregroundColor(.blue)
                .animation(animation)
            if outerPercent < 1 {
                WXArc(type: .outer, percent: _outerPercent, showAsDot: true)
                    .foregroundColor(.black)
            }
        }
    }

    var innerView: some View {
        ZStack {
            WXArc(type: .inner, percent: 1)
                .foregroundColor(.gray)
            WXArc(type: .inner, percent: _innerPercent)
                .foregroundColor(.purple)
                .animation(animation)
            if innerPercent < 1 {
                WXArc(type: .inner, percent: _innerPercent, showAsDot: true)
                    .foregroundColor(.black)
            }
        }
    }

    var animation: Animation {
        Animation.easeInOut(duration: 1.5)//.repeatForever(autoreverses: true)
    }
}

private struct WXArc: Shape {
    enum BoundaryType {
        case outer
        case inner
    }

    let type: BoundaryType
    var percent: CGFloat // 0...1
    let showAsDot: Bool // draws a dot at the beginning of the path

    private var padding: CGFloat { type == .outer ? 0 : 16 } // 0 - for outer circle, 16 - for inner circle

    private let baseAngle: CGFloat = 25 // 0...90
    
    var animatableData: CGFloat {
        get { return percent }
        set { percent = newValue }
    }

    init(type: BoundaryType, percent: CGFloat, showAsDot: Bool = false) {
        self.type = type
        self.percent = percent
        self.showAsDot = showAsDot
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.size.width / 2
        let radius = midX - padding
        let angle = adjustedAngle(for: radius)
        let startAngle = angle
        let endAngle = showAsDot ? angle - 0.001 : 180 - angle
        let percentAngle = showAsDot ? 0 : (360 - (endAngle - startAngle)) * (1 - percent)

        path.addArc(center: CGPoint(x: midX, y: midX),
                    radius: radius,
                    startAngle: Angle(degrees: startAngle - percentAngle),
                    endAngle: Angle(degrees: endAngle),
                    clockwise: true)

        return path
            .strokedPath(.init(lineWidth: 8, lineCap: .round))
    }

    private func adjustedAngle(for radius: CGFloat) -> CGFloat {
        let baseInRadians = baseAngle * Double.pi / 180
        let resultInRadians = asin(sin(baseInRadians) * radius / (radius - padding))

        return resultInRadians * 180 / Double.pi
    }
}

struct WXCircularProgressPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WXCircularProgress(outerPercent: 1,
                               innerPercent: 0.4,
                               action: { },
                               content: Text("Content View"))
            
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
