//
//  CalculateViewController.swift
//  DOPFE
//
//  Created by Daniil Batin on 10.05.2022.
//

import UIKit
import RealmSwift

class CalculateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var resultPeopleArray:Results<Person>!
    var finalProduct: Results<Product>!
    var currentResultPeopleArray:[Person] = []
    var currentProductArray:[Product] = []
    var finalAmount: Float = 0
    var amountForOnePerson:Float = 0
    var realm = try! Realm()
    
    @IBOutlet weak var resultTotalAmount: UILabel!
    @IBOutlet weak var resultTableView: UITableView!
    
    
    // MARK: ViewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        resultPeopleArray = realm.objects(Person.self)
        finalProduct = realm.objects(Product.self)
        currentResultPeopleArray = resultPeopleArray.map{$0}
        currentProductArray = finalProduct.map{$0}
        
        countFinalAmount()
        countAmountForOnePerson()
        countOfDepositAndPaidProduct()
        resultTableView.reloadData()
    }

    
    // Function which count total amount
    
    func countFinalAmount() {
        finalAmount = 0
        for index in currentProductArray {
            finalAmount += Float(index.myprice ?? "0") ?? 0
        }
        resultTotalAmount.text = "\(NSLocalizedString("totalAmount", comment: "")) \(finalAmount) \(NSLocalizedString("uah", comment: ""))"
    }
    
    
    // Function which count amount to pay for one person
    
    func countAmountForOnePerson() {
        if currentResultPeopleArray.count != 0 {
            amountForOnePerson = 0
            amountForOnePerson = (finalAmount / Float(currentResultPeopleArray.count))
        } else { amountForOnePerson = 0 }
    }
    
    
    // Function which calculate the price for each person, considering the paid products and availability of a deposit
    
    func countOfDepositAndPaidProduct() {
        for index in currentResultPeopleArray {
            try! realm.write {
                index.mustPay = 0
                index.mustPay = Float(amountForOnePerson - index.deposit - index.pricePaidForProduct)
            }
        }
    }
    
    
    // MARK: TableView
    
    // Amount of cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentResultPeopleArray.count
    }
    
    
    // Create cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        cell.personName.text = currentResultPeopleArray[indexPath.row].name
        let priceToPay = currentResultPeopleArray[indexPath.row].mustPay
        if priceToPay < 0 {
            cell.amountNeedToPay.text = "\(NSLocalizedString("needToTake", comment: "")) \(String(format: "%.1f", -currentResultPeopleArray[indexPath.row].mustPay)) \(NSLocalizedString("uah", comment: ""))"
        } else {
            cell.amountNeedToPay.text = "\(NSLocalizedString("needToPay", comment: "")) \(String(format: "%.1f", currentResultPeopleArray[indexPath.row].mustPay)) \(NSLocalizedString("uah", comment: ""))"
        }
        return cell
    }
    
}
