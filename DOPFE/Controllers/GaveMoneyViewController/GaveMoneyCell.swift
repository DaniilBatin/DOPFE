//
//  gaveMoneyCell.swift
//  DOPFE
//
//  Created by Daniil Batin on 01.05.2022.
//

import Foundation
import UIKit
import RealmSwift

class GaveMoneyCell: UITableViewCell {
    
    var person = Person()
    let realm = try! Realm()
    
    @IBOutlet weak var nameOfPerson: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
  
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameOfPerson.text = self.person.name
    }
    
    
    // TextField action
    
    @IBAction func editingDidEndAction(_ sender: UITextField) {
        guard let deposit = amountTextField.text
        else {return}
        try! realm.write {
            person.deposit = Float(deposit ) ?? 0
        }
    }
    
}
