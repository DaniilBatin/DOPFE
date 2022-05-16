//
//  ViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 01.04.2022.
//

import UIKit
import RealmSwift

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let realm = try! Realm()
    var arrayOfNames:[Person] = []
    var arrayFromPeople:Results<Person>!
    var observerAddNewPerson:Bool = false
   
    @IBOutlet weak var nameOfPersonTextField: UITextField!
    @IBOutlet weak var tableViewPeople: UITableView!
    @IBOutlet weak var viewWithNameAndAddButton: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        informationLabel.adjustsFontSizeToFitWidth = true
        
        // Remove keyboard from display by tap
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
       
    }
    
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
        
    
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewWithNameAndAddButton.center = .init(x: -viewWithNameAndAddButton.frame.width, y: 119.5)
        createViewWithNumberOfPeopleAnimation()

        arrayFromPeople = realm.objects(Person.self)
        arrayOfNames = arrayFromPeople.map{$0}
        tableViewPeople.reloadData()
    }

    
    //MARK: Create TableView
    
    // create amount of cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayOfNames.count != 0 {
            return arrayOfNames.count
        } else {
            return 0
        }
    }
    
    
    // Create cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PeopleCell
        cell.nameOfPersonLabel.text = arrayOfNames[indexPath.row].name
        return cell
    }
    
   
    // Function which create animation
    
    func createViewWithNumberOfPeopleAnimation() {
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: .calculationModeLinear, animations: {
            self.viewWithNameAndAddButton.center = .init(x: 207, y: 119.5)
        })
    }
    
 
    //MARK: Add New Person Action
    
    @IBAction func addNewPerson(_ sender: Any) {
        
        // Create alert
        
        if nameOfPersonTextField.hasText == false {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: ""),
                                          message: NSLocalizedString("nameAlert", comment: ""),
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("okay", comment: ""), style:.cancel, handler: nil))
            self.present(alert, animated: true)
            return
        } else {
            
            // Create object, append to array(arrayOfNames) and add array to DataBase
            
            let newPerson = Person()
            newPerson.name = nameOfPersonTextField.text!
            arrayOfNames.append(newPerson)
            nameOfPersonTextField.text = ""
            try! realm.write{
                realm.add(arrayOfNames)
            }
            tableViewPeople.reloadData()
        }
    }
    
    
}

