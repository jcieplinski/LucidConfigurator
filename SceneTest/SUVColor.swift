import SwiftUI

enum SUVColor: String, CaseIterable, Identifiable {
  case stellarWhite = "#F4F6ED"  // From CarColor
  case abyssBlack = "#070707"
  case auroraGreen = "#5a5b4e"
  case quantumGrey = "#4E5257"   // From CarColor
  case supernovaBronze = "#413f38"
  case lunarTitanium = "#898781"
  
  var color: Color {
    Color(hex: rawValue)!
  }
  
  var title: String {
    switch self {
    case .abyssBlack: return "Abyss Black"
    case .auroraGreen: return "Aurora Green"
    case .supernovaBronze: return "Supernova Bronze"
    case .lunarTitanium: return "Lunar Titanium"
    case .stellarWhite: return "Stellar White"
    case .quantumGrey: return "Quantum Grey"
    }
  }
  
  var id: String { rawValue }
}
