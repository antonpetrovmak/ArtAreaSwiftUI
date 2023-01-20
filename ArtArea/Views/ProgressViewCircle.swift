//
//  ProgressViewCircle.swift
//  ArtArea
//
//  Created by Anton Petrov on 02.04.2022.
//

import SwiftUI

struct ProgressViewCircle: View {
    @State private var progress = 0.2
    @State private var strokeWidth: CGFloat = 100
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(GaugeProgressStyle(strokeWidth: strokeWidth))
                .frame(width: 200)
                .onTapGesture {
                    if progress < 1.0 {
                        withAnimation {
                            progress += 0.2
                        }
                    }
                }
            Slider(value: $progress, in: 0...1)
            Slider(value: $strokeWidth, in: 1...200)
        }
    }
}

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted =
        configuration.fractionCompleted ?? 0
        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth,
                                                        lineCap: .butt))
                .rotationEffect(.degrees(-90))
        }
        
    }
}

struct ProgressViewCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewCircle()
            .previewDevice("iPhone 12")
    }
}

