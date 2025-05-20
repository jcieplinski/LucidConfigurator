//
//  LucidConfigurator.swift
//  SceneTest
//
//  Created by Joe Cieplinski on 5/18/25.
//

import SwiftUI

@main
struct LucidConfigurator: App {
    init() {
        // Force dark mode for the entire app
        UIWindow.appearance().overrideUserInterfaceStyle = .dark
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
