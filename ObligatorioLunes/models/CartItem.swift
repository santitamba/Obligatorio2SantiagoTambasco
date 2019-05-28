//
//  Cart.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper

class CartItem {
    
    var productId: Int?
    var quantity: Int?

    required init?(map: Map) { }
    
    init(){}
    
    init(productId: Int?) {
        self.productId = productId
        self.quantity = 1
    }
    
}

extension CartItem: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        productId <- map["product_id"]
        quantity <- map["quantity"]
    }
}
