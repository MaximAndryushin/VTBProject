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
    static let shared = DataManager(numberConverter: NumberConverter(), emailConverter: EmailConverter(converter: BreachConverter()))
    
    
    //MARK: - Properties
    
    private let numberConverter: NumberDTODAOConverter
    private let emailConverter: EmailDTODAOConverter
    
    private init(numberConverter: NumberDTODAOConverter, emailConverter: EmailDTODAOConverter) {
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
    }
    
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
    
    func deleteAllInstancesOf(entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
}



// MARK: - PhoneEmail protocol

protocol PhoneEmailDataManager {
    func getPhoneNumbers() -> [PhoneNumber]?
    func getEmails() -> [Email]?
    func deleteNumber(_ name: String)
    func deleteEmail(_ name: String)
}

extension DataManager: PhoneEmailDataManager {
    
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
    
    func deleteNumber(_ name: String) {
        let request = PhoneNumber.fetchRequest()
        request.predicate = NSPredicate(format: "number == %@", name)
        do {
            let results = try managedObjectContext.fetch(request)
            if !results.isEmpty {
                results.forEach { managedObjectContext.delete($0 as! NSManagedObject) }
            }
        } catch {
            print(error)
        }
        saveContext()
    }
    
    func deleteEmail(_ name: String) {
        let request = Email.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", name)
        do {
            let results = try managedObjectContext.fetch(request)
            if !results.isEmpty {
                results.forEach { managedObjectContext.delete($0 as! NSManagedObject) }
            }
        } catch {
            print(error)
        }
        saveContext()
    }
    
    func clearUserData() {
        deleteAllInstancesOf(entity: "\(Email.self)")
        deleteAllInstancesOf(entity: "\(PhoneNumber.self)")
        deleteAllInstancesOf(entity: "\(Breach.self)")
    }
}


//MARK: - PhoneEmailFavoritesProtocol

protocol PhoneEmailFavoritesDataManager {
    func getFavoritesNumbers() -> [PhoneNumber]?
    func getFavoritesEmails() -> [Email]?
    func addToFavoritesNumber(_ numberDTO: NumberDTO)
    func addToFavoritesEmail(_ emailDTO: EmailDTO)
    func deleteFromFavoritesNumber(_ name: String)
    func deleteFromFavoritesEmail(_ name: String)
}

extension DataManager: PhoneEmailFavoritesDataManager {
    
    func addToFavoritesNumber(_ numberDTO: NumberDTO) {
        var number = existsNumber(numberDTO.number)
        numberConverter.update(&number, numberDTO: numberDTO)
        number!.isRenewable = true
        saveContext()
    }
    
    func addToFavoritesEmail(_ emailDTO: EmailDTO) {
        var email = existsEmail(emailDTO.email)
        emailConverter.update(&email, email: emailDTO)
        email!.isRenewable = true
        saveContext()
    }
    
    
    func getFavoritesNumbers() -> [PhoneNumber]? {
        let fetchRequest = PhoneNumber.numberFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isRenewable == true")
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
    
    func getFavoritesEmails() -> [Email]? {
        let fetchRequest = Email.emailFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isRenewable == true")
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
    
    func deleteFromFavoritesNumber(_ name: String) {
        let number = existsNumber(name)
        number!.isRenewable = false
        saveContext()
    }
    
    func deleteFromFavoritesEmail(_ name: String) {
        let email = existsEmail(name)
        email!.isRenewable = false
        saveContext()
    }
    
}


//MARK: - Has number/email protocol

protocol ExistsData {
    func existsNumber(_ number: String) -> PhoneNumber?
    func existsEmail(_ email: String) -> Email?
}

extension DataManager: ExistsData {
    
    
    func existsNumber(_ number: String) -> PhoneNumber? {
        let request = PhoneNumber.fetchRequest()
        request.predicate = NSPredicate(format: "number == %@", number)
        do {
            let results = try managedObjectContext.fetch(request)
            if !results.isEmpty, let number = results.first as? PhoneNumber {
                return number
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func existsEmail(_ email: String) -> Email? {
        let request = Email.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let results = try managedObjectContext.fetch(request)
            if !results.isEmpty, let email = results.first as? Email {
                return email
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
}
