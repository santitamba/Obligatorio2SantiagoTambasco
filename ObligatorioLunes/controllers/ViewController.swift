//
//  ViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 29/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Kingfisher

protocol UpdateCartDelegate {
    func add(item: SuperItem)
    func remove(item: SuperItem)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var slideCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    //var imgArr=[UIImage(named:"Banner-1"),UIImage(named:"Banner-2"),UIImage(named:"Banner-3"),UIImage(named:"Banner-4")]
    var imgArr:[Banners] = []
    var timer=Timer()
    var counter=0
    let sections=["fruits","veggies","dairys"]
    var searchedItem = [[SuperItem]]()
    //var searchedItem = [[SupermarketItem]]()
    var searching = false
    //var items = [[SupermarketItem]]()
    var items = [[SuperItem]]()
    //var currentItems = [[SupermarketItem]]()
    var currentItems = [[SuperItem]]()
    var fruits = [SuperItem]()
    var veggies = [SuperItem]()
    var dairys = [SuperItem]()
    var products = [SuperItem]()
    
    var cartItems = [CartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        //pageView.numberOfPages=imgArr.count
        pageView.currentPage=0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        setUpItems()
        setUpBanners()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        pageView.numberOfPages=imgArr.count
//        pageView.currentPage=0
//        myTableView.reloadData()
    }
    
    private func setUpBanners(){
        ApiManager.shared.obtainBanners { (banners, error) in
            guard let banners = banners else {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            
            self.imgArr = banners
            self.slideCollectionView.reloadData()
            
        }
        
    }
    
    private func setUpItems() {
        // Fruits
        //currentItems.append([SupermarketItem(quantity:0, price:30, name: "kiwi", id:1), SupermarketItem(quantity:0, price:45, name: "Watermelon", id:2), SupermarketItem(quantity:0, price:45, name: "Grapefruit", id:3)])
        // Veggies
        //currentItems.append([SupermarketItem(quantity:0, price:30, name: "Avocado", id:4),SupermarketItem(quantity:0, price:30, name: "Cucumber", id:5)])
        // Fruits
        
        ApiManager.shared.obtainProducts { (products, error) in
            if let products = products{
                //self.prueba = products
                for product in products {
                    switch product.category! {
                    case "fruits":
                        self.fruits.append(product)
                    case "dairy":
                        self.dairys.append(product)
                    default:
                        self.veggies.append(product)
                    }
                }
                self.currentItems.append(self.fruits)
                self.currentItems.append(self.veggies)
                self.currentItems.append(self.dairys)
                
                self.myTableView.reloadData()
            }
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func changeImage(){
        counter = counter == imgArr.count-1 ? 0 : counter + 1
        let index = IndexPath(row: counter, section: 0)
        slideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)

    }

    
    
    
    @IBAction func ClickCartButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    @IBAction func CartButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="SecondViewSegue"{
            if let controller = segue.destination as? SecondScreenViewController{
                
                //currentItems.filter({$0.productId == item.id}).first
                //controller.cart = currentItems[0].filter({$0.quantity! > 0})
                //controller.elements=SessionManager.cartItems!
                
                var tempElements0 = currentItems[0].filter({$0.quantity! >= 0 }) //Le paso todo lo de la seccion 0
                let tempElements1 = currentItems[1].filter({$0.quantity! >= 0 })//Le paso todo lo de la seccion 1
                let tempElements2 = currentItems[2].filter({$0.quantity! >= 0 })//Le paso todo lo de la seccion 1
                tempElements0.append(contentsOf: tempElements1)
                tempElements0.append(contentsOf: tempElements2)
                controller.cart=tempElements0
                
                //controller.elements=currentItems

                //controller.elements = currentItems
                //var tempElements0 = currentItems[0].filter({$0.quantity > 0 }) //Le paso todo lo de la seccion 0
                //let tempElements1 = currentItems[1].filter({$0.quantity > 0 })//Le paso todo lo de la seccion 1
                //tempElements0.append(contentsOf: tempElements1)
                //controller.elements = tempElements0
                
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedItem[section].count
        } else {
            if currentItems.count==0{
                return 0
            }
            else{
                return currentItems[section].count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let item = searching ? searchedItem[indexPath.section][indexPath.row] : currentItems[indexPath.section][indexPath.row]
        
        cell.item = item
        
        cell.delegate = self
        
        cell.configureCell()
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return(sections.count)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellSlide = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSlide", for: indexPath)
        
        let item = imgArr[indexPath.row]
        
        if let photoUrl = item.photoUrl {
            let url = URL(string: photoUrl)
            if let vc=cellSlide.viewWithTag(111) as? UIImageView{
                vc.kf.setImage(with: url)
            }
            else if let ab=cellSlide.viewWithTag(222) as? UIPageControl{
                ab.currentPage = indexPath.row
            }
        }
        
        return cellSlide
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.counter = indexPath.row
        self.pageView.currentPage = counter
    }
    
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    
    //Esto es para que el ancho y largo del item sea igual a mi collectionview
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size=slideCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == ""
        {
            searching = false
            myTableView.reloadData()
        }else{
            searchedItem =  [currentItems[0].filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}), currentItems[1].filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}), currentItems[2].filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}) ]
            searching = true
            myTableView.reloadData()
        }
    }
    
}

extension ViewController: UpdateCartDelegate {
    
    func add(item: SuperItem) {
        
        var currentItems = SessionManager.cartItems ?? []
        
        if var current = currentItems.filter({$0.productId == item.id}).first{
            current.quantity = (current.quantity ?? 0) + 1
            item.quantity = (item.quantity ?? 0) + 1
        } else {
            let newItem = CartItem(productId: item.id)
            currentItems.append(newItem)
            item.quantity = 1
        }
        
        SessionManager.cartItems = currentItems
    }
    
    func remove(item: SuperItem) {
        SessionManager.cartItems = SessionManager.cartItems?.filter {$0.productId != item.id}
    }
    
}
