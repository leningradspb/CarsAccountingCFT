//
//  Cars+CoreDataProperties.swift
//  CarsAccounting
//
//  Created by Eduard Sinyakov on 10/6/19.
//  Copyright © 2019 Eduard Sinyakov. All rights reserved.
//
//

import Foundation
import CoreData


extension Cars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cars> {
        return NSFetchRequest<Cars>(entityName: "Cars")
    }

    @NSManaged public var carsBrandName: String?
    @NSManaged public var carsModelName: String?
    @NSManaged public var datesOFMade: String?
    @NSManaged public var typesOfCars: String?

}
