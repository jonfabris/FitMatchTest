//
//  LogonViewModel.swift
//  FitMatchTest
//
//  Created by Jon Fabris on 2/18/25.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = "username"
    @Published var password: String = "password"
    @Published var errorMessage: String? = nil
    
    func login() -> Bool {
        // Simulate login logic (replace with real API call)
        if username == "username" && password == "password" {
            return true
        } else {
            errorMessage = "Invalid username or password."
            return false
        }
    }
    
/*
    I would use OAuth 2.0 and JSON Web Tokens. The Logon screen would communicate to the server to do the authentication and return a token which would expire after a certain amount of time. The token can be stored on the device’s keychain and if it has not expired they can restart the app without logging in again. You would also want to use multi factor authentication for extra security.
    All of this is what we did in my previous job, and it seems to be the best approach.
 */
}

