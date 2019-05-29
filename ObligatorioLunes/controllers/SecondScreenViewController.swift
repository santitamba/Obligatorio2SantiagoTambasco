//
//  SecondScreenViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 6/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
class SecondScreenViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource
{

    @IBOutlet var ChechoutButton: UIButton!
    @IBOutlet var TotalPriceLabel: UILabel!
    @IBOutlet weak var SecondView: UICollectionView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    let pickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var itemPickerSelected: Int = -1
    let untis=0
    var elements=[CartItem]()
    var totalPrice: Double = 0
    var quantPiker: Int?
    var cart=[SuperItem]()
    var cartItems = SessionManager.cartItems

    override func viewDidLoad() {
        super.viewDidLoad()
        ChechoutButton.layer.cornerRadius=10
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.isHidden = true
        picker.showsSelectionIndicator = true
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantPiker=pickerData[row]
        picker.isHidden = true
        elements[row].quantity=quantPiker!
        for x in 0..<elements.count{
            if elements[x].productId==itemPickerSelected{
                elements[x].quantity=quantPiker!
            }

        }
        SecondView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems!.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellSecondView=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSecondView", for: indexPath) as? ViewControllerSeconViewCell else { return UICollectionViewCell()}
        
        //SessionManager.cartItems = SessionManager.cartItems?.filter {$0.productId != item.id}
        //var currentItems = SessionManager.cartItems ?? []
       // if var current = currentItems.filter({$0.productId == item.id}).first{
        //    current.quantity = (current.quantity ?? 0) + 1
        //} else {
         //   let newItem = CartItem(productId: item.id)
          //  currentItems.append(newItem)
       // }
        //SessionManager.cartItems = currentItems
        
        //buscar en la elements el elemento con el id de ese elemen y trabajo con ese
        var itemCartId = cartItems![indexPath.row].productId
        var current = cart.filter({$0.id! == itemCartId}).first
        //cart=cart.filter($0.id == itemCartId)
        //if var current = cart[indexPath.row].filter($0.id == cartItems[indexPath.row].id){
        //if var current = cartItems?.filter({$0.productId ==  cellSecondView.item.id}).first{
        //    itemPickerSelected=cellSecondView.item.id!
         //   let itemPrice = Double(current.quantity!) * cellSecondView.item.price!
          //  totalPrice = totalPrice + itemPrice
        //}else{
        //    print("hola")
       // }
        
        
        //cellSecondView.item = cart[indexPath.row]
        cellSecondView.item = current
        itemPickerSelected=cellSecondView.item.id!

        for car in cart{
            let itemPrice = Double(car.price!) * Double(car.quantity!)
            totalPrice = totalPrice + itemPrice

        }
        TotalPriceLabel.text = "$" + String(totalPrice)
        if elements.count>0{
            ChechoutButton.isEnabled=true
        }
        cellSecondView.configure()
        
        return cellSecondView
    }
    
    //Atencion
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let index = pickerData.index(of: elements[itemPickerSelected].id)
        //picker.selectRow(index!, inComponent: 0, animated: false)
        let cell = SecondView.cellForItem(at: indexPath) as! ViewControllerSeconViewCell
        itemPickerSelected=cell.item.id!
        picker.isHidden = false
       

    }

    func indexAlert(alert: UIAlertAction!){
        SessionManager.deleteAllData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CheckOutButtonAction(_ sender: Any) {
        
       
        if let cart = SessionManager.cartItems {
            ApiManager.shared.postPurchase(cart: cart) { (success, errorMessage) in
                var title = "Error"
                var message = errorMessage
                var buttonTitle = "OK"
                if success {
                    title = "Successful"
                    message = "Congratulation for purchase in the Shop"
                    buttonTitle = "Accept"
                }
                let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: buttonTitle,style: .default, handler: self.indexAlert))
                self.present(alert, animated: true)
            }
        }
    }
    
}
