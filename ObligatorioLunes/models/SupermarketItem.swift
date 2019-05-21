//
//  SupermarketItem.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 1/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
class SupermarketItem{
    let id : Int
    var quantity : Int
    let price : Int
    let name: String
    //let category: CategoryType
    //let image: String
    
    
    init(quantity: Int, price: Int, name:String, id:Int /*, category:CategoryType , image:String*/) {
        self.quantity = quantity
        self.price = price
        self.name = name
        self.id = id
        //self.category = category
       // self.image = image
    }
    
    func clean(){
        self.quantity=0
    }
}
/*enum CategoryType:String{
    case fruits = "Fruit"
    case veggies = "Veggies"
}*/
