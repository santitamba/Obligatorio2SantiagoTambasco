//
//  PurchaseViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 27/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var purchaseTableView: UITableView!
    
    var purchases = [Purchase]()
    var cart = [ProductCart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPurchases()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        //checkoutCartViewController.purchaseCart = purchases[(purchaseTableView.indexPathForSelectedRow?.row)!].convertToCart()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let controller = segue.destination as! SecondScreenViewController
            controller.elements=SessionManager.cartItems!
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellPurchase = tableView.dequeueReusableCell(withIdentifier: "cellPurchase", for: indexPath) as! ViewControllerPurchaseViewCellTableViewCell
        
        cellPurchase.purchase = purchases[indexPath.row]
        
        cellPurchase.configureCell()
        
        return cellPurchase
    
    }
    
    
    private func setUpPurchases(){
        ApiManager.shared.obtainPurchases { (purchases, error) in
            guard let purchases = purchases else {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            
            self.purchases = purchases
            self.purchaseTableView.reloadData()
            
        }
        
    }

    @IBAction func ClickDetailsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "DetailsViewSegue", sender: self)
    }
}
