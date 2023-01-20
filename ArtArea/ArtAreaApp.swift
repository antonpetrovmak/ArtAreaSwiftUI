//
//  ArtAreaApp.swift
//  ArtArea
//
//  Created by Anton Petrov on 27.03.2022.
//

import SwiftUI

@main
struct ArtAreaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TestViewModel())
            //CarouselExample()
        }
    }
}
