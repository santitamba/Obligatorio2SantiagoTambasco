//
//  SuperItem.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper
class SuperItem{
var id : Int?
var name : String?
var price : Double?
var category : String?
var photoUrl : String? {
    didSet{
        guard let photoUrl = photoUrl else{
            self.photoUrl="https://upload.wikimedia.org/wikipedia/commons/f/f2/Escudo_de_Pe%C3%B1arol.svg"
            return
        }
    }
    }


    required init?(map: Map) {
    }
}

extension SuperItem: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        category <- map["category"]
        photoUrl <- map["photoUrl"]
    }
}