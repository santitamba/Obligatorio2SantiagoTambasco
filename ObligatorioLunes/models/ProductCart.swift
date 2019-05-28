//
//  ProductCart.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 23/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductCart{
    var product : SuperItem?
    var quantity : Int?
    
    required init?(map: Map) {
    }
}

extension ProductCart: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        product <- map["product"]
        quantity <- map["quantity"]
    }
}
