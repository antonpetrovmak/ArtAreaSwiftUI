//
//  HikeView.swift
//  ArtArea
//
//  Created by Anton Petrov on 28.03.2022.
//

import SwiftUI

extension AnyTransition {
    static var cardTrans: AnyTransition {
        let insertion = AnyTransition
            .move(edge: .top)
            .combined(with: .opacity)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

class HikeViewViewModel: ObservableObject {
    @Published var numbers: [Int] = [Int]()
}

struct HikeView: View {

    @ObservedObject var vm = HikeViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if !vm.numbers.isEmpty {
                        ForEach(vm.numbers, id: \.self) { number in
                            Card(number: number)
                                .padding(0)
                                .transition(.cardTrans)
                        }
                    }
                }
                .animation(.spring(response: 1, dampingFraction: 0.8, blendDuration: 0), value: vm.numbers)
            }
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarItems(trailing: console)
            .onAppear { vm.numbers = [1, 2] }
        }
    }

    private var console: some View {
        HStack {
            Button(action: {
                let number = (0...1000).randomElement() ?? 0
                vm.numbers.append(number)
            }) {
                Image(systemName: "plus.circle.fill")
            }

            Button(action: {
                guard !vm.numbers.isEmpty,
                      let index = (0...(vm.numbers.count - 1)).randomElement()
                else { return }
                vm.numbers.remove(at: index)
            }) {
                Image(systemName: "minus.circle")
            }
        }
    }
}

extension Animation {
    static func card(duration: Double = 1, delay: Double = 0.1) -> Animation {
        Animation
            .easeOut(duration: duration)
            .delay(delay)
    }
}

struct CardSetup: ViewModifier {
    let didAppear: Bool

    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: didAppear ? 0 : -10)
            .opacity(didAppear ? 1 : 0)
    }
}

struct BaseCard: View {

    @State private var didAppear = false

    let contentViews: [AnyView]

    var body: some View {
        VStack(spacing: 10) {
            ForEach((0...contentViews.count - 1), id: \.self) { index in
                contentViews[index]
                    .modifier(CardSetup(didAppear: didAppear))
                    .animation(.card(delay: 0.5 * (Double(index) + 1)))
            }
        }
        .onAppear {
            didAppear = true
        }
        .padding(20)
        .clipped()
        .background(Color.blue.opacity(0.1))
    }
}

struct Card: View {

    @State var didAppear = false
    @State var oneTimeAnimation = true
    let number: Int

    var body: some View {
        VStack(spacing: 10) {
            accountItem
                .modifier(CardSetup(didAppear: didAppear))
                .animation(.card(delay: 0.5), value: didAppear)

            balanceItem
                .modifier(CardSetup(didAppear: didAppear))
                .animation(.card(delay: 1.0), value: didAppear)

            addFundsItem
                .modifier(CardSetup(didAppear: didAppear))
                .animation(.card(delay: 1.5), value: didAppear)

        }
        .onAppear {
            didAppear.toggle()
        }
        .padding(20)
        .background(Color.blue.opacity(0.1))
    }

    private var accountItem: some View {
        HStack {
            Text("ACCOUTNS #\(number)")
                .foregroundColor(.gray)
                .font(.caption2)
            Spacer()
            Text("See all")
                .foregroundColor(.gray)
                .font(.caption2)
        }
    }

    private var balanceItem: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Total Balance")
                    .foregroundColor(.gray)
                    .font(.caption2)
                Text("$12,030.43")
                    .font(.title)
            })
            Spacer()
        }
    }

    private var addFundsItem: some View {
        HStack() {
            Button("+ Add Funds") {

            }
            .foregroundColor(.white)
            .background(Color.green)
            .padding(.vertical, 10)
            Spacer()
        }
    }

}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView()
            Spacer()
        }
        .previewDevice("iPhone 12")
    }
}

