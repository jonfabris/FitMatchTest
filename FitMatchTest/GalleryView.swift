//
//  GalleryView.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/18/25.
//

import SwiftUI
import QuickLookThumbnailing

struct GalleryView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var viewModel = GalleryViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach(viewModel.models) { item in
                    Button(action: {
                        appCoordinator.push(.detail(item: item))
                    }){
                        modelView(item)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Gallery")
    }
    
    func modelView(_ model: Model3d) -> some View {
        VStack {
            if(model.thumbnailImage != nil) {
                model.thumbnailImage
            }
                
            Text(model.name)
        }
    }
}

