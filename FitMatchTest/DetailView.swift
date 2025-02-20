//
//  DetailView.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/19/25.
//

import Foundation
import SwiftUI
import RealityKit

struct DetailView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var viewModel: DetailViewModel
    
    @State private var rotation: SIMD3<Float> = [0, 0, 0]
    @State private var scale: Float = 1.0
    @State private var offset: SIMD3<Float> = [0, 0, 0]
    
    @State private var isDragging: Bool = true

    var body: some View {
        ZStack {
            RealityKitView(modelName: viewModel.item.name, rotation: $rotation, scale: $scale, offset: $offset)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                
                VStack {
                    Button("Recenter") {
                        offset = [0, 0, 0]
                        rotation = [0, 0, 0]
                    }.padding(4)
                    
                    HStack {
                        Picker("Options", selection: $isDragging) {
                            Text("Drag").tag(true)
                            Text("Rotate").tag(false)
                        }
                        .pickerStyle(.segmented)
                    }
                }.background(Color.white)
            }
        }
        .gesture(
             SimultaneousGesture(
                 DragGesture()
                     .onChanged { value in
                         if(isDragging) {
                             offset.x += Float(value.translation.width) * 0.001
                             offset.y -= Float(value.translation.height) * 0.001
                         } else {
                             rotation.x += Float(value.translation.height) * 0.001
                             rotation.y += Float(value.translation.width) * 0.001
                         }
                     },
                 MagnificationGesture()
                     .onChanged { value in
                         scale = Float(value.magnitude)
                     }
             )
         )
    }
}

struct RealityKitView: UIViewRepresentable {
    let modelName: String
    @Binding var rotation: SIMD3<Float>
    @Binding var scale: Float
    @Binding var offset: SIMD3<Float>

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Load model and add to scene
        if let modelEntity = try? Entity.loadModel(named: modelName) {
            let anchorEntity = AnchorEntity(world: .zero)
            anchorEntity.addChild(modelEntity)
            arView.scene.anchors.append(anchorEntity)

            // Set model reference in coordinator
            context.coordinator.modelEntity = modelEntity
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Apply transformations to the model
        guard let modelEntity = context.coordinator.modelEntity else { return }
        
        modelEntity.transform.translation = offset
        modelEntity.transform.scale = [scale, scale, scale]
        
        modelEntity.transform.rotation = simd_mul(
            simd_quatf(angle: rotation.x, axis: [1, 0, 0]),
            simd_quatf(angle: rotation.y, axis: [0, 1, 0])
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var modelEntity: ModelEntity?
    }
}
