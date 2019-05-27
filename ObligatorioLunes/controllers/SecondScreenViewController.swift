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
    var elements=[SupermarketItem]()
    var totalPrice: Double = 0
    var quantPiker: Int?

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
        //elements[row].quantity=quantPiker!
        for x in 0..<elements.count{
            if elements[x].id==itemPickerSelected{
                elements[x].quantity=quantPiker!
                print(elements[x].name)
            }

        }
        SecondView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellSecondView=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSecondView", for: indexPath) as? ViewControllerSeconViewCell else { return UICollectionViewCell()}
       
        cellSecondView.item = elements[indexPath.row]
        //itemPickerSelected=cellSecondView.item.id

        for element in elements{
            let itemPrice = Double(element.quantity) * Double(element.price)
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
        itemPickerSelected=cell.item.id
        picker.isHidden = false
       

    }

    func indexAlert(alert: UIAlertAction!){
        for element in elements{
            element.clean()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CheckOutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Successful", message: "Congratulation for purchase in the Shop",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: indexAlert))
        self.present(alert, animated: true)
    }
    
}
