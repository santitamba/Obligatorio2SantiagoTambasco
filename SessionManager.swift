//
//  SessionManager.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 5/27/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation

class SessionManager: NSObject {
    
    static let shared = SessionManager()
    
    static var cartItems: [CartItem]?
    
    static func deleteAllData(){
        self.cartItems = []
    }
}
