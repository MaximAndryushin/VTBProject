//
//  Breach+CoreDataProperties.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 05.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//
//

import Foundation
import CoreData


extension Breach {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Breach> {
        return NSFetchRequest<Breach>(entityName: "\(Breach.self)")
    }

    @NSManaged public var addedDate: String?
    @NSManaged public var domain: String?
    @NSManaged public var info: String?
    @NSManaged public var logoPath: String?
    @NSManaged public var modifiedDate: String?
    @NSManaged public var name: String?
    @NSManaged public var emails: NSSet?

}

// MARK: Generated accessors for emails
extension Breach {

    @objc(addEmailsObject:)
    @NSManaged public func addToEmails(_ value: Email)

    @objc(removeEmailsObject:)
    @NSManaged public func removeFromEmails(_ value: Email)

    @objc(addEmails:)
    @NSManaged public func addToEmails(_ values: NSSet)

    @objc(removeEmails:)
    @NSManaged public func removeFromEmails(_ values: NSSet)

}
