//
//  MaterialMenu.swift
//  ArtArea
//
//  Created by Anton Petrov on 20.09.2022.
//

import Foundation
import SwiftUI

struct MaterialMenu: View {
    @State private var change = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            Divider()
            ZStack {
                Group {
                    Button(action: { self.change.toggle() }) {
                        Image(systemName: "bag.badge.plus")
                        .padding(24)
                        //.rotationEffect(Angle.degrees(change ? 0 : 90))
                    }
                    .background(Circle().fill(Color.green).shadow(radius: 8, x: 4, y: 4))
                    .offset(x: 0, y: change ? -100 : 0)
                    .opacity(change ? 1 : 0)
                    .animation(.easeInOut(duration: 1))
                    
                    Button(action: { self.change.toggle() }) {
                        Image(systemName: "gauge.badge.plus")
                        .padding(24)
                        //.rotationEffect(Angle.degrees(change ? 0 : 90))
                    }
                    .background(Circle().fill(Color.green).shadow(radius: 8, x: 4, y: 4))
                    .offset(x: 0, y: change ? -200 : 0)
                    .opacity(change ? 1 : 0)
                    .animation(.easeInOut(duration: 1).delay(change ? 1 : 0))
                    
                    Button(action: { self.change.toggle() }) {
                        Image(systemName: "calendar.badge.plus")
                        .padding(24)
                        //.rotationEffect(Angle.degrees(change ? 0 : 90))
                    }
                    .background(Circle().fill(Color.green).shadow(radius: 8, x: 4, y: 4))
                    .offset(x: 0, y: change ? -300 : 0)
                    .opacity(change ? 1 : 0)
                    .animation(.easeInOut(duration: 1).delay(change ? 2 : 0))
                    
                    Button(action: { self.change.toggle() }) {
                        Image(systemName: "plus")
                        .padding(24)
                        .rotationEffect(Angle.degrees(change ? 45 : 0))
                    }
                    .background(Circle().fill(Color.green).shadow(radius: 8, x: 4, y: 4))
                }
                .padding(20)
                .foregroundColor(.white)
            }
            
            Divider()
            
            Button("Change") {
                self.change.toggle()
            }
            
        }
        .font(.title)
    }
}


struct MaterialMenu_Previews: PreviewProvider {
    static var previews: some View {
        MaterialMenu()
            .previewDevice("iPhone 12")
    }
}
