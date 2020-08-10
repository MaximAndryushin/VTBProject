//
//  PhoneNumber+CoreDataProperties.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 07.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//
//

import Foundation
import CoreData


extension PhoneNumber {

    @nonobjc public class func numberFetchRequest() -> NSFetchRequest<PhoneNumber> {
        return NSFetchRequest<PhoneNumber>(entityName: "\(PhoneNumber.self)")
    }

    @NSManaged public var carrier: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var countryName: String?
    @NSManaged public var countryPrefix: String?
    @NSManaged public var date: Date?
    @NSManaged public var lineType: String?
    @NSManaged public var location: String?
    @NSManaged public var number: String?
    @NSManaged public var valid: Bool
    @NSManaged public var isRenewable: Bool

}
