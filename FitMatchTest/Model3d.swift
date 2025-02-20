//
//  Model3d.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/19/25.
//

import Foundation
import SwiftUI

struct Model3d: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var thumbnailImage: Image? = nil
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Model3d, rhs: Model3d) -> Bool {
        lhs.id == rhs.id
    }
}
