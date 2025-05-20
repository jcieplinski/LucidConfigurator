//
//  CarColor.swift
//  SceneTest
//
//  Created by Joe Cieplinski on 5/19/25.
//

import SwiftUI

enum CarColor: String, CaseIterable, Identifiable {
  case stellarWhite = "#F4F6ED"
  case infiniteBlack = "#1F2022"
  case zenithRed = "#4B1718"
  case fathomBlue = "#657286"
  case cosmosSilver = "#A3A7B0"
  case quantumGrey = "#4E5257"
  case eurekaGold = "#79786B"
  
  var color: Color {
    Color(hex: rawValue)!
  }
  
  var title: String {
    switch self {
    case .stellarWhite: return "Stellar White"
    case .zenithRed: return "Zenith Red"
    case .fathomBlue: return "Fathom Blue"
    case .infiniteBlack: return "Infinite Black"
    case .cosmosSilver: return "Cosmos Silver"
    case .quantumGrey: return "Quantum Grey"
    case .eurekaGold: return "Eureka Gold"
    }
  }
  
  var id: String { rawValue }
}
