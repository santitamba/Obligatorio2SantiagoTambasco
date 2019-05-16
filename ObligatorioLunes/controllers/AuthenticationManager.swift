//
//  AuthenticationManager.swift
//  EjercicioApi
//
//  Created by Alvaro Rose on 5/13/19.
//  Copyright © 2019 Alvaro Rose. All rights reserved.
//

import Foundation

class AuthenticationManager {
    static var shared = AuthenticationManager()
    fileprivate let tokenKey = "tokenKey"
    
    private init() {
        
    }
    
    func authenticate(onCompletion: @escaping (AuthenticationResponse) -> Void) {
        var response: AuthenticationResponse!
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            response = AuthenticationResponse(token: token)
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: tokenKey)
            response = AuthenticationResponse(token: uuid)
        }
        let randomDouble = Double.random(in: 1...2)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDouble) {
            onCompletion(response)
        }
    }

}
