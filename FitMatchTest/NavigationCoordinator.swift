//
//  NavigationCoordinator.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/19/25.
//

import Foundation
import Combine
import SwiftUI

enum Screen: Identifiable, Hashable {
    case logon
    case gallery
    case detail(item: Model3d)
    
    var id: Self { return self }
}

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.logon)
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
        }
        .environmentObject(appCoordinator)
    }
}

class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .logon:
            LogonView()
        case .gallery:
            GalleryView()
        case .detail(let item):
            DetailView(viewModel: DetailViewModel(item: item))
        }
    }
}
