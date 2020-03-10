//
//  AuthenticationSession.swift
//  Firebase-Auth-Lab
//
//  Created by Kelby Mittan on 3/10/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthenticationSession {
    
    public func createNewUser(email: String, password: String, completion: @escaping(Result<AuthDataResult,Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authDataResult = authDataResult {
                completion(.success(authDataResult))
            }
        }
    }
    
    public func signExistingUser(email: String, password: String, completion: @escaping(Result<AuthDataResult,Error>) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authDataResult = authDataResult {
                completion(.success(authDataResult))
            }
        }
    }
}
