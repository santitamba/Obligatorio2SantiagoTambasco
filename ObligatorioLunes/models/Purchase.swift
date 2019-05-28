//
//  Purchase.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper
class Purchase{
    var date : Date?
    var products : [ProductCart]?
    
    required init?(map: Map) {
    }
}

extension Purchase: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        date <- (map["date"],CustomDateTransform())
        products <- map["products"]
    }
}
