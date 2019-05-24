//
//  ViewControllerTableViewCell.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 30/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var MyLabel: UILabel!
    @IBOutlet weak var MyLabelPrice: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabelQuant: UILabel!
    @IBOutlet weak var myButtonAddFirst: UIButton!
    @IBOutlet var myButtonMinus: UIButton!
    @IBOutlet var myButtonPlus: UIButton!
    //var item : SupermarketItem!
    @IBOutlet var stepperView: UIView!
    var item : SuperItem!
    var cartItem: CartItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.layer.cornerRadius = myImage.frame.width / 2
        myImage.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        //if cartItem.quantity! > 0 {
            self.stepperView.isHidden = false
            self.myButtonAddFirst.isHidden = true
            updateLabel()
        //} else {
        //    self.stepperView.isHidden = true
        //    self.myButtonAddFirst.isHidden = false
        //}
        
        MyLabel.text = item.name
        MyLabelPrice.text = "$ " + String(describing: item.price)
        myImage.image = UIImage(named: item.name!)
        //myLabelQuant.text=String(describing: cartItem.quantity)
    }
    
    func updateLabel() {
        myLabelQuant.text="1"
        //myLabelQuant.text = String(describing: cartItem.quantity)
    }


    
    public func changeStepperVisible() {
        self.stepperView.isHidden = !self.stepperView.isHidden
        self.myButtonAddFirst.isHidden = !self.myButtonAddFirst.isHidden
    }

    public func changeStepperInVisible() {
        self.stepperView.isHidden = true
        self.myButtonAddFirst.isHidden = false
    }

    
    @IBAction func myButtonAdd(_ sender: UIButton) {
        changeStepperVisible()
        cartItem.quantity = 1
        updateLabel()
    }
    @IBAction func myButtonPlus(_ sender: UIButton) {
        cartItem.quantity = cartItem.quantity! + 1
        updateLabel()
    }
    @IBAction func myButtonMinus(_ sender: UIButton) {
        if cartItem.quantity == 1{
            changeStepperInVisible()
            cartItem.quantity = cartItem.quantity! - 1
        }
        else{
            cartItem.quantity = cartItem.quantity! - 1
            updateLabel()
        }
    }
    
}
