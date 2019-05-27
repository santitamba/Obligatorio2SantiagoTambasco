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
    var token : String?
    
    private init(){
        AuthenticationManager.shared.authenticate { (authResponse) in
            print(authResponse)
            self.token = authResponse.token
        }
    }
    
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
    
    func obtainBanners(onCompletion: @escaping ([Banners]?,Error?) -> Void) {
        let url = baseUrl + "promoted"
        
        Alamofire.request(url).responseArray { (response: DataResponse<[Banners]>)  in
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
    
    func obtainPurchases(onCompletion: @escaping ([Purchase]?, Error?) -> Void) {
        let url =  baseUrl + "purchases"
        let headers: HTTPHeaders = ["Authorization": "Bearer " + self.token!]
        
        Alamofire.request(url,method: .get, headers: headers)
            .responseArray{(response: DataResponse<[Purchase]>) in
                switch response.result {
                case .success:
                    onCompletion(response.result.value, nil)
                case .failure(let error):
                    onCompletion(nil, error)
                    print(error)
                }
        }
    }
    
}
