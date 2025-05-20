//
//  ColorButton.swift
//  SceneTest
//
//  Created by Joe Cieplinski on 5/18/25.
//

import SwiftUI

struct ColorButton: View {
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }
}
