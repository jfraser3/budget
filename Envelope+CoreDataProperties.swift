//
//  Envelope+CoreDataProperties.swift
//  Budget-App
//
//  Created by Joshua Fraser on 2/20/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//
//

import Foundation
import CoreData


extension Envelope {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Envelope> {
        return NSFetchRequest<Envelope>(entityName: "Envelope")
    }

    @NSManaged public var name: String?
    @NSManaged public var index: Int64
    @NSManaged public var amount: Double
    @NSManaged public var image: String?

}
