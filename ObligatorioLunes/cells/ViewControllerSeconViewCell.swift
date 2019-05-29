//
//  ViewControllerSeconViewCell.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 7/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewControllerSeconViewCell: UICollectionViewCell{
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var itemSubtitle: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemTitle: UILabel!
    var item : SuperItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        itemTitle.text = item.name
        itemPrice.text = "$ " + String(item.price! * Double(item.quantity!))
        
        itemSubtitle.text = String(describing: item.quantity!)
        + " units"
        //imageView.image = UIImage(named: item.name!)
        
        if let photoUrl = item.photoUrl {
            let url = URL(string: photoUrl)
            imageView.kf.setImage(with: url)
        }
        
    }
    
    
//
//    MyLabel.text = item.name
//    MyLabelPrice.text = "$ " + String(item.price)
//    myImage.image = UIImage(named: item.name)
//    myLabelQuant.text=String(item.quantity)
    
}
