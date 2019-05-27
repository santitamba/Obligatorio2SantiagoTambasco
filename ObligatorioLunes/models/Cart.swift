//
//  Cart.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 23/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper

class Cart: Mappable {
    var cart: [CartItem]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        cart <- map["cart"]
    }
    
}


