//
//  ApiManager.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 22/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiManager{
    static let shared = ApiManager()
    
    private let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net/"
    private init(){}
    
    func obtainProducts(onCompletion: @escaping ([SuperItem]?,Error?) -> Void) {
        let url = baseUrl + "products"
        
        Alamofire.request(url).responseArray { (response: DataResponse<[SuperItem]>)  in
            switch response.result{
            case .success:
                //on completion y poner el error en nil y pasarle al sucess lo de abajo
                onCompletion(response.result.value, nil)
            case .failure(let error):
                //oncompletion y poner el sucess en nil y pasarle el error
                onCompletion(nil, error)
                print(error)
            }
            //Luego en el view controler llamo ApiManager.shared.obtainProducts y deberia tener los productos
        }
    }
    
}
