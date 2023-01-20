//
//  ContentView.swift
//  ArtArea
//
//  Created by Anton Petrov on 27.03.2022.
//

import Foundation
import SwiftUI

protocol ContentVMP: ObservableObject {
    var configs: [SomeItem.Config] { get }
}

struct ContentView<ViewModel: ContentVMP>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.configs, id: \.self) { config in
                SomeItem(config: config)
            }
        }
    }
}

struct SomeItem: View {
    struct Config: Hashable {
        let text: String
        let value: Int
    }
    
    let config: Config
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(config.text)
                    .font(.system(size: 20))
                    .background(Color.random)
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color.random)
                Spacer()
            }
            
            Button {
                
            } label: {
                Text("\(config.value)")
                    .font(.system(size: 20))
                    .background(Color.random)
            }
        }
        .background(Color.random)
    }
}

class TestViewModel: ContentVMP {
    @Published var configs: [SomeItem.Config] = []
    
    var timer = Timer()
    
    init() {
        configs = [
            .init(text: "Text 0", value: 0),
            .init(text: "Text 1", value: 1),
            .init(text: "Text 2", value: 2)
        ]
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if Bool.random() {
            configs = (0...configs.count - 1).map { i in
                let value = Bool.random() ? i : -(i)
                return .init(text: "Text \(i)", value: value)
            }
        } else {
            configs = configs + [.init(text: "Text \(configs.count)", value: configs.count)]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: TestViewModel())
            .previewLayout(.device)
    }
}
