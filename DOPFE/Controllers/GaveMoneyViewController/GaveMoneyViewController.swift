//
//  GaveMoneyViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 01.05.2022.
//

import UIKit
import RealmSwift

class GaveMoneyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var arrayFromPeople:Results<Person>!
    var realm = try! Realm()
    var peopleArray:[Person] = []
    
    @IBOutlet weak var gaveMoneyTableView: UITableView!
    @IBOutlet weak var hideView: UIView!
       
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        arrayFromPeople = realm.objects(Person.self)
        peopleArray = arrayFromPeople.map{$0}
        deleteDepositFromPeople()
        hideView.isHidden = true
        print(peopleArray)
        
        //Remove keyboard by touch
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
   
    
    //MARK: TableView
    
    // Amount of cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if peopleArray.count != 0 {
            return peopleArray.count
        }
        return 0
    }
    
    
    // Create cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gaveMoneyCell", for: indexPath) as! GaveMoneyCell
        cell.person = peopleArray[indexPath.row]
        return cell
    }

    
    // Save button action which reload Data
    
    @IBAction func saveChooseAction(_ sender: Any) {
        gaveMoneyTableView.reloadData()
        print(peopleArray)
        hideView.isHidden = false
    }
    
    
    // Function which delete property deposin in objects Person in array
    
    func deleteDepositFromPeople() {
        for index in peopleArray {
            try! realm.write {
                index.deposit = 0
            }
        }
    }
    
}
