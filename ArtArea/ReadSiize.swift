//
//  ReadSiize.swift
//  ArtArea
//
//  Created by Anton Petrov on 27.09.2022.
//

import Foundation
import SwiftUI

struct ReadContentView: View {
    @State private var change = false
    @State private var animateOnChange = false
    @GestureState private var someOffset: CGSize = .zero
    @State private var text = ""
    
    @State private var height: CGFloat = 0
    
    private enum Field: Int, CaseIterable {
        case textField
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Rectangle()
                        .background(.brown)
                        .frame(width: .infinity, height: 100)
                }
                
                GeometryReader(content: { scrollViewProxy in
                    ScrollView {
                        VStack(alignment: .center, spacing: 0) {
                            TextField("TextField", text: $text)
                                .focused($focusedField, equals: .textField)
                                .padding(20)
                                .background(Color.gray)
                            
                            VStack {
                                GeometryReader(content: { geometry in
                                    let minY = geometry.frame(in: .named("WXContentSkeletonView_ScrollView")).minY
                                    let bottomViewHeight = max(scrollViewProxy.size.height - minY - 100, 72)
                                    ZStack {
                                        //Color.clear.frame(width: .infinity, height: .infinity, alignment: .center)
                                        Text("\(text) \(bottomViewHeight) - \(height)")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 17))
                                            .padding(.horizontal, 20)
                                            .frame(width: .infinity, height: bottomViewHeight)
                                            .background(Color.yellow)
                                    }
                                    .readSize(onChange: { size in
                                        height = size.height
                                    })
                                })
                                .frame(height: height, alignment: .center)
                            }
                            
                            Rectangle()
                                .background(.brown)
                                .frame(width: .infinity, height: 100)
        
                        }
                        
                    }
                    .coordinateSpace(name: "WXContentSkeletonView_ScrollView")
                    .onTapGesture {
                        focusedField = nil
                    }
                })
            }.navigationTitle("Title")
        }
    }
}

private extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


struct ReadContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReadContentView()
            .previewDevice("iPhone 12")
    }
}
