//
//  ViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 29/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var slideCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    

    
    
    var imgArr=[UIImage(named:"Banner-1"),UIImage(named:"Banner-2"),UIImage(named:"Banner-3"),UIImage(named:"Banner-4")]
    var timer=Timer()
    var counter=0
    let sections=["fruits","veggies"]
    var searchedItem = [[SuperItem]]()
    //var searchedItem = [[SupermarketItem]]()
    var searching = false
    var items = [[SupermarketItem]]()
    //var currentItems = [[SupermarketItem]]()
    var currentItems = [[SuperItem]]()
    var fruits = [SuperItem]()
    var veggies = [SuperItem]()
    var dairys = [SuperItem]()
    let apiManager = ApiManager.shared
    //var products = [Products]()
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="SecondViewSegue"{
            if let controller=segue.destination as? SecondScreenViewController{
                //var tempElements0 = currentItems[0].filter({$0.quantity > 0 }) //Le paso todo lo de la seccion 0
                //let tempElements1 = currentItems[1].filter({$0.quantity > 0 })//Le paso todo lo de la seccion 1
                //tempElements0.append(contentsOf: tempElements1)
                //controller.elements = tempElements0
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        myTableView.delegate = self
        myTableView.dataSource = self
        pageView.numberOfPages=imgArr.count
        pageView.currentPage=0
        DispatchQueue.main.async {
            self.timer=Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        //Este es el SetUp que comente para pasar a recibir por ws
        //setUpItems()
        myTableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpItems()
        myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpItems() {
        // Fruits
        //currentItems.append([SupermarketItem(quantity:0, price:30, name: "kiwi", id:1), SupermarketItem(quantity:0, price:45, name: "Watermelon", id:2), SupermarketItem(quantity:0, price:45, name: "Grapefruit", id:3)])
        // Veggies
        //currentItems.append([SupermarketItem(quantity:0, price:30, name: "Avocado", id:4),SupermarketItem(quantity:0, price:30, name: "Cucumber", id:5)])
        // Fruits
        
        apiManager.obtainProducts { (products, error) in
            if let products = products{
                //self.prueba = products
                for product in products{
                    if product.category=="fruits"{
                        self.fruits.append(product)
                    }
                    if product.category=="dairy"{
                        self.dairys.append(product)
                    }
                    else{
                        self.veggies.append(product)
                    }
                }
                self.currentItems.append(self.fruits)
                self.currentItems.append(self.veggies)
                self.currentItems.append(self.dairys)
                //dairy
                self.myTableView.reloadData()
            }
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searching {
            return searchedItem[section].count
        } else {
            return currentItems.count
        }
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let item = searching ? searchedItem[indexPath.section][indexPath.row] : currentItems[indexPath.section][indexPath.row]
       
        cell.item = item
        
        cell.configureCell()
    
        
        return cell
    }
 
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return(sections.count)
    }
    
    @objc func changeImage(){
        if counter<imgArr.count{
            let index=IndexPath.init(item: counter, section: 0)
            self.slideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage=counter
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.slideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage=counter
            counter=1
        }
    }
    
    

    
    @IBAction func ClickCartButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    @IBAction func CartButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellSlide=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSlide", for: indexPath)
        if let vc=cellSlide.viewWithTag(111) as? UIImageView{
            vc.image=imgArr[indexPath.row]
        }
        else if let ab=cellSlide.viewWithTag(222) as? UIPageControl{
            ab.currentPage=indexPath.row
        }
        return cellSlide
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
            searchedItem =  [currentItems[0].filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}), currentItems[1].filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()}) ]
            searching = true
            myTableView.reloadData()
        }
    }

    
    
}
