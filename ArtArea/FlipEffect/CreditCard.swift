//
//  CreditCard.swift
//  ArtArea
//
//  Created by Anton Petrov on 24.10.2022.
//

import SwiftUI

struct CreditCard<SideView1: View, SideView2: View>: View, Animatable {
    
    let sideView1: SideView1
    let sideView2: SideView2
    
    @State var degrees: CGFloat = 0
    @State var flipped = false
    @State var angle: CGFloat = 0
        
    var body: some View {
        Color.clear.overlay(
            Group {
                if !flipped {
                    sideView1
                } else {
                    sideView2
                    .rotation3DEffect(.degrees(180), axis: (0,1,0))
                }
            }
            .cornerRadius(10)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1.5)) {
                    angle = angle == 180 ? 0 : 180
                }
            }
        )
        .modifier(FlipEffect(flipped: $flipped, angle: angle, axis: (x: 0, y: 1)))
        .modifier(ScaleSinZAnimation(degrees: angle))
        //.modifier(OffsetSinYAnimation(degrees: angle))
    }
    
}

struct ScaleSinZAnimation: AnimatableModifier {
    var degrees: CGFloat

    var animatableData: CGFloat {
        get { degrees }
        set { degrees = newValue }
    }

    func body(content: Content) -> some View {
        let value = (1 - abs(0.3 * sin(degrees * Double.pi / 180)))
        content
            .scaleEffect(value)
    }
}

struct OffsetSinYAnimation: AnimatableModifier {
    var degrees: CGFloat

    var animatableData: CGFloat {
        get { degrees }
        set { degrees = newValue }
    }

    func body(content: Content) -> some View {
        let value = (40 - abs(40 * sin(degrees * Double.pi / 180)))
        content
            .offset(y: value)
    }
}

private struct FlipEffect: GeometryEffect {
    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }
    @Binding var flipped: Bool
    var angle: CGFloat
    let axis: (x: CGFloat, y: CGFloat)
    func effectValue(size: CGSize) -> ProjectionTransform {
        // We schedule the change to be done after the view has finished drawing,
        // otherwise, we would receive a runtime error, indicating we are changing
        // the state while the view is being drawn.
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        let a = CGFloat(Angle(degrees: angle).radians)
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
