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
    
    let pickerElements = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var itemPickerSelected: Int = -1
    let untis=0
    var elements=[CartItem]()
    var totalPrice: Double = 0
    var quantPiker: Int?
    var cart=[SuperItem]()
    var cartPurch=[SuperItem]()
    var cartItems = SessionManager.cartItems
    var readOnlye = false

    override func viewDidLoad() {
        super.viewDidLoad()
        ChechoutButton.layer.cornerRadius=10
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        self.SecondView.delegate=self
        self.SecondView.dataSource=self

        if readOnlye==false{
            picker.isHidden = true
            picker.showsSelectionIndicator = true
            ChechoutButton.isEnabled=false
            if ChechoutButton.isEnabled==false{
                ChechoutButton.alpha=0.5
            }
            else{
                ChechoutButton.alpha=1
            }
        }
        else{
            picker.isHidden = true
            picker.showsSelectionIndicator = false
            ChechoutButton.isHidden=true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalAmount()
        SecondView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if readOnlye==false{
            if let cart=cartItems{
                return cartItems!.count
            }
            else{
                return 0
            }
        }
        else{
            return cartPurch.count
        }

        
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellSecondView=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSecondView", for: indexPath) as? ViewControllerSeconViewCell else { return UICollectionViewCell()}
        
        if readOnlye==false{
            var itemCartId = cartItems![indexPath.row].productId
            var current = cart.filter({$0.id! == itemCartId}).first
            
            //cellSecondView.item = cart[indexPath.row]
            cellSecondView.item = current
            //itemPickerSelected=cellSecondView.item.id!
            
            //for car in cart{
              //  let itemPrice = Double(car.price!) * Double(car.quantity!)
             //   totalPrice = totalPrice + itemPrice
                
            //}
            //TotalPriceLabel.text = "$" + String(totalPrice)
            if cartItems!.count>0{
                ChechoutButton.isEnabled=true
            }
            cellSecondView.configure()
            
            return cellSecondView
        }
        else{
            //for e in cartPurch{
            //    cellSecondView.item = e
            //}
            cellSecondView.item = cartPurch[indexPath.row]
            //for car in cartPurch{
            //    let itemPrice = Double(car.price!) * Double(car.quantity!)
             //   totalPrice = totalPrice + itemPrice
           // }
            //TotalPriceLabel.text = "$" + String(totalPrice)
            ChechoutButton.isEnabled=false
            if ChechoutButton.isEnabled==false{
                ChechoutButton.alpha=0.5
            }
            else{
                ChechoutButton.alpha=1
            }
            picker.isHidden=true
            cellSecondView.configure()
            return cellSecondView
        }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerElements[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantPiker=pickerElements[row]
        picker.isHidden = true
        cart[row].quantity=quantPiker!
        //cartItems![row].quantity=quantPiker!
        for x in 0..<cartItems!.count{
            if cart[x].id==itemPickerSelected{
                cart[x].quantity=quantPiker!
                cartItems![x].quantity=quantPiker!
            }
            
        }
        SecondView.reloadData()
        totalAmount()
    }
    
    //Atencion
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let index = pickerElements.index(of: elements[itemPickerSelected].id)
        //picker.selectRow(index!, inComponent: 0, animated: false)
        if readOnlye==false{
            let cell = SecondView.cellForItem(at: indexPath) as! ViewControllerSeconViewCell
            itemPickerSelected=cell.item.id!
            picker.isHidden = false
        }
        else{
            return
        }

    }
    
    func totalAmount(){
            //.filter({$0.id! == itemCartId}).first
        if readOnlye==false{
            totalPrice=0
            if let cartItems = cartItems{
                for elem in cartItems{
                    var unitPrice = cart.filter({$0.id! == elem.productId}).first?.price
                    totalPrice = totalPrice+(Double(elem.quantity!) * unitPrice!)
                }
                TotalPriceLabel.text = "$" + String(totalPrice)
            }
            else{
                TotalPriceLabel.text = "$" + String(totalPrice)
            }

        }
        else{
            totalPrice=0
            for ele in cartPurch{
                totalPrice=totalPrice+(ele.price! * Double(ele.quantity!))
            }
            TotalPriceLabel.text = "$" + String(totalPrice)
        }

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
