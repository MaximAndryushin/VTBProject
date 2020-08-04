//
//  Email+CoreDataProperties.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//
//

import Foundation
import CoreData


extension Email {

    @nonobjc public class func emailFetchRequest() -> NSFetchRequest<Email> {
        return NSFetchRequest<Email>(entityName: "Email")
    }

    @NSManaged public var email: String?
    @NSManaged public var isValid: Bool
    @NSManaged public var reason: String?
    @NSManaged public var isDisposable: Bool
    @NSManaged public var role: Bool
    @NSManaged public var isFree: Bool
    @NSManaged public var safeToSend: Bool
    @NSManaged public var domain: String?
    @NSManaged public var user: String?
    @NSManaged public var isVerified: Bool
    @NSManaged public var isSpamList: String?
    @NSManaged public var isRetired: Bool
    @NSManaged public var isFabricated: Bool
    @NSManaged public var breaches: NSSet?

}

// MARK: Generated accessors for breaches
extension Email {

    @objc(addBreachesObject:)
    @NSManaged public func addToBreaches(_ value: Breach)

    @objc(removeBreachesObject:)
    @NSManaged public func removeFromBreaches(_ value: Breach)

    @objc(addBreaches:)
    @NSManaged public func addToBreaches(_ values: NSSet)

    @objc(removeBreaches:)
    @NSManaged public func removeFromBreaches(_ values: NSSet)

}
