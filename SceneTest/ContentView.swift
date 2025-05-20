//
//  ContentView.swift
//  SceneTest
//
//  Created by Joe Cieplinski on 5/18/25.
//

import SwiftUI
import SceneKit

enum CarModel: String, CaseIterable {
    case air = "Air"
    case gravity = "Gravity"
    case sapphire = "Sapphire"
    
    var displayTitle: String {
        switch self {
        case .air: return "Air"
        case .gravity: return "Gravity"
        case .sapphire: return "Sapphire"
        }
    }
}

struct ContentView: View {
    @State private var selectedModel: CarModel = .air
    @State private var showPlatinum = true
    @State private var showGlassRoof = true
    @State private var airPaintColor = CarColor.stellarWhite
    @State private var suvPaintColor = SUVColor.stellarWhite
    @State private var selectedAirWheel: AirWheelOption? = .aero19
    @State private var selectedGravityWheel: GravityWheelOption? = .aether
    @State private var isGT = false
    @State private var shouldResetCamera = false
    @State private var sceneImage: UIImage?
    @State private var isShareSheetPresented = false
    @State private var currentSceneView: SCNView?
    @State private var isCapturing = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Model switcher
                HStack(spacing: 12) {
                    ForEach(CarModel.allCases, id: \.self) { model in
                        Button(action: {
                            selectedModel = model
                        }) {
                            Text(model.displayTitle)
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedModel == model ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Scene view container
                ZStack {
                    if selectedModel == .air {
                        SceneKitView(sceneName: "Air.scn",
                                   showPlatinum: $showPlatinum,
                                   showGlassRoof: $showGlassRoof,
                                   carPaintColor: $airPaintColor,
                                   selectedWheel: $selectedAirWheel,
                                   isGT: $isGT,
                                   shouldResetCamera: $shouldResetCamera,
                                   onViewCreated: { view in
                                       DispatchQueue.main.async {
                                           // Configure view for transparency
                                           view.backgroundColor = .clear
                                           view.scene?.background.contents = nil
                                           currentSceneView = view
                                       }
                                   })
                    } else if selectedModel == .gravity {
                        SceneKitViewGravity(showPlatinum: $showPlatinum,
                                          carPaintColor: $suvPaintColor,
                                          selectedWheel: $selectedGravityWheel,
                                          shouldResetCamera: $shouldResetCamera,
                                          onViewCreated: { view in
                                              DispatchQueue.main.async {
                                                  // Configure view for transparency
                                                  view.backgroundColor = .clear
                                                  view.scene?.background.contents = nil
                                                  currentSceneView = view
                                              }
                                          })
                    } else {
                        SceneKitViewSapphire(shouldResetCamera: $shouldResetCamera,
                                           onViewCreated: { view in
                                               DispatchQueue.main.async {
                                                   // Configure view for transparency
                                                   view.backgroundColor = .clear
                                                   view.scene?.background.contents = nil
                                                   currentSceneView = view
                                               }
                                           })
                    }
                }
                .frame(height: 400)
                .background(Color.black)
                
                // Controls
                ScrollView {
                    VStack(spacing: 16) {
                        if selectedModel != .sapphire {
                            HStack(spacing: 12) {
                                Button(action: {
                                    showPlatinum.toggle()
                                }) {
                                    Text(showPlatinum ? "Platinum" : "Stealth")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                
                                if selectedModel == .air {
                                    Button(action: {
                                        showGlassRoof.toggle()
                                    }) {
                                        Text(showGlassRoof ? "Glass" : "Metal")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    }
                                    
                                    Button(action: {
                                        isGT.toggle()
                                    }) {
                                        Text(isGT ? "GT" : "Non-GT")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(isGT ? Color.red : Color.blue)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .frame(height: 44)
                            
                            Button(action: {
                                shouldResetCamera = true
                            }) {
                                HStack {
                                    Image(systemName: "arrow.counterclockwise")
                                    Text("Reset View")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(10)
                            }
                            
                            // Color buttons
                            HStack(spacing: 12) {
                                if selectedModel == .air {
                                    ForEach(CarColor.allCases) { color in
                                        ColorButton(color: color.color) {
                                            airPaintColor = color
                                        }
                                    }
                                } else {
                                    ForEach(SUVColor.allCases) { color in
                                        ColorButton(color: color.color) {
                                            suvPaintColor = color
                                        }
                                    }
                                }
                            }
                            
                            // Wheel selection buttons
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    if selectedModel == .air {
                                        ForEach(AirWheelOption.allCases, id: \.self) { wheel in
                                            WheelButton(
                                                wheelName: wheel.displayTitle,
                                                isSelected: selectedAirWheel == wheel
                                            ) {
                                                if selectedAirWheel == wheel {
                                                    selectedAirWheel = nil
                                                } else {
                                                    selectedAirWheel = wheel
                                                }
                                            }
                                        }
                                    } else {
                                        ForEach(GravityWheelOption.allCases, id: \.self) { wheel in
                                            WheelButton(
                                                wheelName: wheel.displayTitle,
                                                isSelected: selectedGravityWheel == wheel
                                            ) {
                                                if selectedGravityWheel == wheel {
                                                    selectedGravityWheel = nil
                                                } else {
                                                    selectedGravityWheel = wheel
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.black)
            }
            .navigationTitle("Car Configurator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        captureSceneSnapshot()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .opacity(isCapturing ? 0.5 : 1.0)
                    }
                    .disabled(isCapturing)
                }
            }
            .sheet(isPresented: $isShareSheetPresented) {
                if let image = sceneImage {
                    ShareSheet(items: [image])
                        .ignoresSafeArea()
                }
            }
        }
        .background(Color.black)
    }
    
    private func captureSceneSnapshot() {
        guard let view = currentSceneView,
              !isCapturing else {
            print("No scene view available or already capturing")
            return
        }
        
        isCapturing = true
        
        // Ensure we're on the main thread and give the view time to render
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Store original background color
            let originalBackgroundColor = view.backgroundColor
            let originalSceneBackground = view.scene?.background.contents
            
            // Set transparent background
            view.backgroundColor = .clear
            view.scene?.background.contents = nil
            
            // Force a render update
            view.setNeedsDisplay()
            
            // Create a transparent image context
            let size = CGSize(width: view.bounds.width * UIScreen.main.scale,
                            height: view.bounds.height * UIScreen.main.scale)
            
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            defer { UIGraphicsEndImageContext() }
            
            // Clear the context
            UIColor.clear.set()
            UIRectFill(CGRect(origin: .zero, size: size))
            
            // Capture directly from the view to maintain camera position
            let image = view.snapshot()
            
            // Restore original background
            view.backgroundColor = originalBackgroundColor
            view.scene?.background.contents = originalSceneBackground
            
            // Update the image and present share sheet
            self.sceneImage = image
            self.isShareSheetPresented = true
            
            // Reset capturing state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isCapturing = false
            }
        }
    }
}

// ShareSheet view for presenting the system share sheet
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        
        // Configure the share sheet
        if let popoverController = controller.popoverPresentationController {
            popoverController.sourceView = UIView()
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// Color extension to support hex colors
extension Color {
  init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
    
    let red = Double((rgb & 0xFF0000) >> 16) / 255.0
    let green = Double((rgb & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgb & 0x0000FF) / 255.0
    
    self.init(red: red, green: green, blue: blue)
  }
}

#Preview {
    ContentView()
}
