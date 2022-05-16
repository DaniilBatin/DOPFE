//
//  WhoPaysViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 30.04.2022.
//

import UIKit
import RealmSwift

class WhoPaysViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
  
    var numberOfComponentsInPickerView:Int = 2
    var arrayFromPeople:Results<Person>!
    var arrayFromPurchases:Results<Product>!
    var currentArrayPeople:[Person] = []
    var currentArrayProduct:[Product] = []
    var newArrayPeople:[Person] = []
    var price:Float = 0
    var nameOfPrice = ""
    var name = ""
    var index:Int = 0
    var index2:Int = 0
    var realm = try! Realm()
 
    @IBOutlet weak var currentChooseLabel: UILabel!
    @IBOutlet weak var whoPaysPickerView: UIPickerView!
    @IBOutlet weak var containerViewWithSegments: UIView!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var paidSegmentControl: UISegmentedControl!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var saveChooseButton: UIButton!
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentChooseLabel.adjustsFontSizeToFitWidth = true
        changeHideState(true)
        
        arrayFromPurchases = realm.objects(Product.self)
        arrayFromPeople = realm.objects(Person.self)
        currentArrayPeople = arrayFromPeople.map{$0}
        currentArrayProduct = arrayFromPurchases.map{$0}
    }
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        containerViewWithSegments.center = .init(x: -containerViewWithSegments.frame.width, y: 122)
        transferButton.center = .init(x: 207, y: 790.5 + transferButton.frame.height)
        createViewWithNumberOfPeopleAnimation()
        
        
    }
    
    
    // MARK: ViewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        arrayFromPurchases = realm.objects(Product.self)
        arrayFromPeople = realm.objects(Person.self)
        currentArrayPeople = arrayFromPeople.map{$0}
        currentArrayProduct = arrayFromPurchases.map{$0}

        whoPaysPickerView.dataSource = self
        whoPaysPickerView.delegate = self
    }

    // Create animation for transfer button and view with label and segmentControl
    
    func createViewWithNumberOfPeopleAnimation() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
            self.containerViewWithSegments.center = .init(x: 207, y: 122)
            self.transferButton.center = .init(x: 207, y: 790.5)
        })
    }

    
    //MARK: PickerView
    
    // Number of Components in a pickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponentsInPickerView
    }
   
    
    // Number of semgents in a pickerView
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return currentArrayProduct.count
        case 1:
            return currentArrayPeople.count
        default:
            return 0
        }
    }
    
    
    // Create title of semgents in pickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let price = currentArrayProduct[row]
            index = row
            return "\(price.name ?? "") \(price.myprice ?? "") \(NSLocalizedString("uah", comment: ""))"
        } else {
            let person = currentArrayPeople[row]
            return person.name
        }
    }

    
    // Output of selected title of segments in pickerView
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            price = Float(currentArrayProduct[row].myprice ?? "0") ?? 0
            index = row
            nameOfPrice = currentArrayProduct[row].name!
            currentChooseLabel.text = "\(nameOfPrice) \(price) \(NSLocalizedString("uah", comment: "")) - \(name)"
        } else {
            name = currentArrayPeople[row].name
            index2 = row
            currentChooseLabel.text = "\(nameOfPrice) \(price) \(NSLocalizedString("uah", comment: "")) - \(name)"
        }
    }
    
    
    //MARK: TableView
    
    // Amount of cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArrayPeople.count
    }
    
    
    // Create cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewResultCell", for: indexPath) as! WhoPaysCell
        cell.resultLabel.text = "\(newArrayPeople[indexPath.row].name) - \(newArrayPeople[indexPath.row].priceName) \(newArrayPeople[indexPath.row].pricePaidForProduct) \(NSLocalizedString("uah", comment: ""))"
        return cell
    }
    
    
    // Save button action wich checks if the label is full and call a function createNewPersonWithPrice()
    @IBAction func saveChooseButton(_ sender: Any) {
        if currentArrayPeople != [] && currentArrayProduct != [] {
            createNewPersonWithPrice()
        }
    }
    
    
    // Create object with selected values and update one in to the DataBase
    
    func createNewPersonWithPrice() {
        let selectedPerson = Person()
        selectedPerson.pricePaidForProduct = price
        selectedPerson.name = name
        selectedPerson.priceName = nameOfPrice
        newArrayPeople.append(selectedPerson)
        try! realm.write({
            arrayFromPeople[index2].pricePaidForProduct += price
        })
        resultTableView.reloadData()
    }
    
    
    // Function which change property isHidden
    
    func changeHideState(_ state: Bool) {
        currentChooseLabel.isHidden = state
        resultTableView.isHidden = state
        whoPaysPickerView.isHidden = state
        saveChooseButton.isHidden = state
    }
    
    
    // Switch SegmentedControl
    
   @IBAction func switchSegmentedControl(_ sender: Any) {
        if paidSegmentControl.selectedSegmentIndex == 1 {
            changeHideState(false)
        } else {
            changeHideState(true)
            newArrayPeople = []
            resultTableView.reloadData()
            try! realm.write({
                for index in arrayFromPeople {
                    index.pricePaidForProduct = 0
                }
            })
        }
    }
    
    
}
