//
//  Persistence.swift
//  Calendarios
//
//  Created by David on 4/8/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Calendarios")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let content  = container.viewContext
        if content.hasChanges {
            do {
                try content.save()
                completion(nil)
            } catch  {
                completion(error)
                print("****** ERROR EN EL GUARDADO \(error)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
