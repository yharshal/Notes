//
//  Backend.swift
//  Notes
//
//  Created by Harshal on 12/12/21.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins

class Backend {
    
    static let shared = Backend()
    
    static func initialize() -> Backend {
        return .shared
    }
    
    private init() {
        // initialize amplify
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }
    
    func fetchCurrentAuthSession() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
                case .success(let session):
                    print("Is user signed in \(session.isSignedIn)")
                case .failure(causedBy: let error):
                    print("fetch session failed with error: \(error.localizedDescription)")
            }
        }
    }
    
}
