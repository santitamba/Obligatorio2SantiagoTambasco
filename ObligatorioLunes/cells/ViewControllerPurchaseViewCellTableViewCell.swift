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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        labelDate.text = String(describing: purchase.date)//"1"//CustomDateTransform.shared.transformToJSON(purchase.date)
        labelTotal.text = "1"
    }
    
    @IBAction func ButtonPurchaseDetails(_ sender: Any) {
    }

}
