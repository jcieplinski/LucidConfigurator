//
//  WheelButton.swift
//  SceneTest
//
//  Created by Joe Cieplinski on 5/18/25.
//

import SwiftUI

struct WheelButton: View {
    let wheelName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(wheelName.replacingOccurrences(of: "Wheel_", with: ""))
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
                )
        }
    }
}
