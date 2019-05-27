//
//  Banners.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import ObjectMapper
class Banners{
    var name : String?
    var description : String?
    var photoUrl : String?

    required init?(map: Map) {
    }
}

extension Banners: Mappable {
    //init?(map: Map) { }
    //mutating
    func mapping(map: Map){
        name <- map["name"]
        description <- map["description"]
        photoUrl <- map["photoUrl"]
    }
}
