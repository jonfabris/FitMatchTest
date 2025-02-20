//
//  LogonView.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/18/25.
//

import SwiftUI

struct LogonView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button("Login") {
                if(viewModel.login()) {
                    appCoordinator.push(.gallery)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogonView()
    }
}

