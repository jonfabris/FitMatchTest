//
//  DetailViewModel.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/20/25.
//

import Combine

class DetailViewModel: ObservableObject {
    var item: Model3d
    
    init(item: Model3d) {
        self.item = item
    }
}
