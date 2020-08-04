//
//  PhoneNumber+CoreDataClass.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//
//

import Foundation
import CoreData


public class PhoneNumber: NSManagedObject {
    convenience init() {
        let entity = DataManager.shared.entityForName("\(PhoneNumber.self)")
        self.init(entity: entity, insertInto: DataManager.shared.managedObjectContext)
    }
}
