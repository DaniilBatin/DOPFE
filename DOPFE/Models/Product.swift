//
//  Product.swift
//  DOPFE
//
//  Created by Daniil Batin on 28.04.2022.
//

import Foundation
import UIKit
import RealmSwift

class Product: Object {
    @objc dynamic var name:String?
    @objc dynamic var myprice:String?
}
