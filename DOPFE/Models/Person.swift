//
//  Person.swift
//  DOPFE
//
//  Created by Daniil Batin on 26.04.2022.
//

import Foundation
import UIKit
import RealmSwift

class Person: Object {
    @objc dynamic var name:String = ""
    @objc dynamic var pricePaidForProduct:Float = 0
    @objc dynamic var priceName:String = ""
    @objc dynamic var deposit: Float = 0
    @objc dynamic var mustPay: Float = 0
}


