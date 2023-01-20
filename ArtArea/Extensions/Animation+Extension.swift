//
//  Animation+Extension.swift
//  ArtArea
//
//  Created by Anton Petrov on 03.04.2022.
//

import SwiftUI

extension View {
    func appearAnimation(using animation: Animation = Animation.easeInOut(duration: 1),
                         _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

struct AnimatableCustomFontModifier: AnimatableModifier {
    var name: String
    var size: CGFloat
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(name: String, size: CGFloat) -> some View {
        self.modifier(AnimatableCustomFontModifier(name: name, size: size))
    }
}

struct JoinText: ViewModifier {
    func body(content: Content) -> some View {
        
    }
}

extension Text {
    
}
