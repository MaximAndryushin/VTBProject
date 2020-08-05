//
//  UserDefaultDataManager.swift
//  HomeWork9
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    //Singltone
    static let shared = DataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppVTB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        return context
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK: - Methods
    
    func entityForName(_ name: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: name, in: self.managedObjectContext)!
    }
    
    func getPhoneNumbers() -> [PhoneNumber]? {
        let fetchRequest = PhoneNumber.numberFetchRequest()
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if !results.isEmpty {
                return results
            }
        } catch {
            print(error)
        }
        return nil
    }
    
}



// MARK: - PhoneEmail protocol
protocol PhoneEmailDataManager {
    func getPhoneNumbers() -> [PhoneNumber]?
    func getEmails() -> [Email]?
}

extension DataManager: PhoneEmailDataManager {
    func getEmails() -> [Email]? {
        let fetchRequest = Email.emailFetchRequest()
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if !results.isEmpty {
                return results
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func deleteAllInstancesOf(entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func clearUserData() {
        deleteAllInstancesOf(entity: "\(Email.self)")
        deleteAllInstancesOf(entity: "\(PhoneNumber.self)")
        deleteAllInstancesOf(entity: "\(Breach.self)")
    }
}
