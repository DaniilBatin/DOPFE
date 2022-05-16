//
//  PurchasesViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 27.04.2022.
//

import UIKit
import RealmSwift

class PurchasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var observerAddNewProduct:Bool = false
    var arrayCompletedPurchases:[Product] = []
    var arrayFromPurchases:Results<Product>!
   
    @IBOutlet weak var nameOfNewProductTextField: UITextField!
    @IBOutlet weak var priceOfNewProductTextField: UITextField!
    @IBOutlet weak var purchasesTableView: UITableView!
    @IBOutlet weak var viewWithTextFieldsAndButton: UIView!
    
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove keyboard by touch
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
       
    }
    
    
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewWithTextFieldsAndButton.center = .init(x: 207, y: -viewWithTextFieldsAndButton.frame.height)
        animationViewWithTextFieldsAndButton()
        
        arrayFromPurchases = realm.objects(Product.self)
        arrayCompletedPurchases = arrayFromPurchases.map{$0}
        purchasesTableView.reloadData()
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // Function which create animation for UIView
    
    func animationViewWithTextFieldsAndButton() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            self.viewWithTextFieldsAndButton.center = .init(x: 207, y: 119.5)
        })
    }
 
    
    //MARK: Create TableView
    
    // Create amount of cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayCompletedPurchases.count != 0 {
            return arrayCompletedPurchases.count
        } else {
            return 0
        }
        
    }
    
    // Create cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! PurchasesCell
        cell.nameOfProductLabel.text = arrayCompletedPurchases[indexPath.row].name
        cell.priceOfProductLabel.text = "\(arrayCompletedPurchases[indexPath.row].myprice ?? "") \(NSLocalizedString("uah", comment: ""))"
        return cell
    }
    
    
    //MARK: Action With Button
    
    @IBAction func addNewProduct(_ sender: Any) {
        
        // Create Alert
        
        if nameOfNewProductTextField.hasText == false || priceOfNewProductTextField.hasText == false {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: ""),
                                          message: NSLocalizedString("productAlert", comment: ""),
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("okay", comment: ""), style:.cancel, handler: nil))
            self.present(alert, animated: true)
            return
        } else {
            
            // Add new object to array(arrayCompletedPurchases)
            
            let newProduct = Product()
            newProduct.name = nameOfNewProductTextField.text
            newProduct.myprice = priceOfNewProductTextField.text
            arrayCompletedPurchases.append(newProduct)
            nameOfNewProductTextField.text = ""
            priceOfNewProductTextField.text = ""
            observerAddNewProduct = true
            purchasesTableView.reloadData()
        }
        
    }
    
    // MARK: ViewWillDissapear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if observerAddNewProduct {
            try! realm.write {
                realm.add(arrayCompletedPurchases)
            }
        observerAddNewProduct = false
        }
    }
    

}
