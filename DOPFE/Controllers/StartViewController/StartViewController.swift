//
//  StartViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 04.05.2022.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {
    
    let startRealm = try! Realm()
   
    @IBOutlet weak var restartButton: UIButton!
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
    }
    
    // Restart Button Action which delete all from DataBase
    
    @IBAction func restartButtonAction(_ sender: Any) {
        try! startRealm.write {
          startRealm.deleteAll()
        }
    }
    
    // Create Button with information Alert
    
    @IBAction func roolsButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "DOPFE",
                                      message: NSLocalizedString("information", comment: ""),
                                      preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("okay", comment: ""), style:.cancel, handler: nil))
        self.present(alert, animated: true)
        return
    }
    
    // MARK: ViewDidDissapear
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        restartButton.isHidden = false
    }
}
