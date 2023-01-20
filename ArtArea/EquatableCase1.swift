//
//  EquatableCase1.swift
//  ArtArea
//
//  Created by Anton Petrov on 24.11.2022.
//

import SwiftUI

typealias VoidHandler = () -> Void

struct C: Equatable {
    let title: String
    let action: VoidHandler
    
    static func == (lhs: C, rhs: C) -> Bool {
        return lhs.title == rhs.title
    }
}

protocol TestVMP: ObservableObject {
    var config: C { get }
    var text: String { get }
}

struct TestView<ViewModel: TestVMP>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button(viewModel.config.title) {
                viewModel.config.action()
            }
            Text("Text: \(viewModel.text)")
        }
        
    }
}

class ViewModel: TestVMP {
    @Published var config: C = .init(title: "", action: { })
    @Published var text: String = "Nothig"
    var value: String = ""
    
    var timer: Timer?
    init() {
        let sss = "\(Date().timeIntervalSince1970)"
        config = .init(title: "Init", action: { [weak self] in
            guard let self = self else { return }
            self.text = sss
        })
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc
    func timerAction() {
        value = "\(Date().timeIntervalSince1970)"
//        config = .init(title: "\(Date().timeIntervalSince1970)",
//                       action: { [weak self] in self?.text = "\(Date().timeIntervalSince1970)" })
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: ViewModel())
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.device)
    }
}
