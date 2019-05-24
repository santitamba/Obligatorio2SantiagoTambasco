//
//  Cart.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper
class CartItem{
    var product_id : Int?
    var quantity : Int?
    
    required init?(map: Map) {
    }
}

extension CartItem: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        product_id <- map["product_id"]
        quantity <- map["quantity"]
    }
}

