//
//  GalleryViewModel.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/19/25.
//

import Foundation
import Combine
import QuickLookThumbnailing
import SwiftUI

class GalleryViewModel: ObservableObject {
    @Published var models: [Model3d] = [
        Model3d(name: "robot"),
        Model3d(name: "robot2"),
    ]
    
    let thumbnailSize = CGSize(width: 40, height: 40)
    let scale = UIScreen.main.scale
    
    var isTapped: Bool = false
    
    init() {
        for model in models {
            generateThumbnail(for: model.name)
        }
    }

    func generateThumbnail(for modelName: String) {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") else {
            print("Error: Could not find resource for \(modelName)")
            return
        }
        
        let request = QLThumbnailGenerator.Request(fileAt: url,
                                                   size: thumbnailSize,
                                                   scale: scale,
                                                   representationTypes: .all)
        
        QLThumbnailGenerator.shared.generateRepresentations(for: request) { [weak self] (thumbnail, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Thumbnail generation failed for \(modelName): \(error.localizedDescription)")
                    return
                }
                
                if let image = thumbnail?.uiImage {
                    self?.updateModelThumbnail(modelName: modelName, image: image)
                }
            }
        }
    }
    
    private func updateModelThumbnail(modelName: String, image: UIImage) {
        if let index = models.firstIndex(where: { $0.name == modelName }) {
            models[index].thumbnailImage = Image(uiImage: image)
        }
    }
    
    func tapThumbnail(model: Model3d) {
        isTapped = true;
    }
}
