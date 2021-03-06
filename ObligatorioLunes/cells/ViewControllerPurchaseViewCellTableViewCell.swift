//
//  ViewControllerPurchaseViewCellTableViewCell.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 27/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewControllerPurchaseViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellPurchase: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    var purchase : Purchase!
    var delegate: showPurchaseDelegate!
    var indexPath: IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureCell() {
        let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd HH:mm"
        labelDate.text = formatter.string(from: purchase.date!)//CustomDateTransform.shared.transformToJSON(purchase.date)
        var totalAmount: Double = 0
        for purch in purchase.products!{
            let pamount = Double(purch.quantity!) * round(1000*(purch.product?.price)!)/1000
            totalAmount = totalAmount + pamount
        }
        labelTotal.text = "$"+String(totalAmount)
    }

    
    @IBAction func ButtonPurchaseDetails(_ sender: Any) {
        delegate.showPurchases(indexPath: indexPath)
    }

}
