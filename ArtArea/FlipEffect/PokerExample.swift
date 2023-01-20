//
//  PokerExample.swift
//  ArtArea
//
//  Created by Anton Petrov on 22.10.2022.
//

import SwiftUI

struct PokerExample: View {
    var body: some View {
        HStack {
            Spacer()
            RotatingCard()
            Spacer()
        }.background(Color.black).navigationBarTitle("Example 8")
    }
}
private struct RotatingCard: View {
    @State private var flipped = false
    @State private var animate3d = false
    @State private var angle: Double = 0
    let images = ["p1"]
    var body: some View {
        return VStack {
            Spacer()
            VStack {
                if flipped {
                    VStack {
                        Text("Back")
                        Image("p1").resizable()
                    }
                    .rotation3DEffect(Angle(degrees: 180), axis: (0,1,0))
                    
                } else {
                    Text("Front")
                    Image("p2").resizable()
                }
            }
                .background(Color.green)
                .frame(width: 212, height: 320)
                //.rotation3DEffect(.degrees(flipped ? 0 : 180), axis: (0,1,0))
                .modifier(FlipEffect(flipped: $flipped, angle: angle /*animate3d ? 0 : 360*/, axis: (x: 0, y: 1)))
//                .onAppear {
//                    withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
//                        self.animate3d = true
//                    }
//                }
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 2), {
                        angle = angle == 180 ? 0 : 180
                    })
                }
            Spacer()
        }
    }
}

private struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    @Binding var flipped: Bool
    var angle: Double
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

struct PokerExample_Previews: PreviewProvider {
    static var previews: some View {
        PokerExample()
            .previewDevice("iPhone 12")
    }
}

