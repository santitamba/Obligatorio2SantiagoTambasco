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
    var delegate: UpdateCartDelegate!
    
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
        let url=URL(string:item.photoUrl!)
        
        self.stepperView.isHidden = true
        self.myButtonAddFirst.isHidden = false
        self.myLabelQuant.text = "0"
        
        if let cartItem = SessionManager.cartItems?.filter({$0.productId == item.id}).first {
            let currentQty = cartItem.quantity ?? 0
            if currentQty > 0 {
                myLabelQuant.text = String(currentQty)
                self.stepperView.isHidden = false
                self.myButtonAddFirst.isHidden = true
            }
        }
        
        MyLabel.text = item.name
        MyLabelPrice.text = "$ " + String(describing: round(1000*item.price!)/1000)
        myImage.kf.setImage(with: url)
    }
    
    func updateLabel(add: Bool) {
        var current = getCurrentQty()
        if add {
            current = current + 1
        } else {
             current = current - 1
        }
        myLabelQuant.text = String(current)
    }
    
    func getCurrentQty() -> Int {
        if let currentQty = Int(myLabelQuant.text ?? "0") {
            return currentQty
        } else {
            return 0
        }
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
        delegate.add(item: item)
        updateLabel(add: true)
    }
    @IBAction func myButtonPlus(_ sender: UIButton) {
        delegate.add(item: item)
        updateLabel(add: true)
    }
    @IBAction func myButtonMinus(_ sender: UIButton) {
        let current = getCurrentQty()
        if current == 1 {
            changeStepperInVisible()
        } else {
            updateLabel(add: false)
        }
        delegate.remove(item: item)
    }
    
}
