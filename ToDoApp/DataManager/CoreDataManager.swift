//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit
import CoreData


class CoreDataManager : DataManagerProtocol {
    
    static let shared = CoreDataManager()
  
    func insert<Entity>(entity: Entity.Type, title: String, detail: String, deadline: Date) -> Entity? {
        let toDoEntity = ToDo(context: CoreDataManaged.context)
        toDoEntity.title = title
        toDoEntity.detail = detail
        toDoEntity.deadline = deadline
        toDoEntity.createdTime = Date()
        toDoEntity.id = UUID()
        
        do {
            try CoreDataManaged.context.save()
            //LocalNotificationManager.shared.scheduleNotification(item: toDoEntity)
            return toDoEntity as? Entity
        } catch {
            let error = CoreDataError.insertError
            print("\(error)")
            return nil
        }
    }
    
    func update<Entity>(entity: Entity.Type, title: String, detail: String, deadline: Date, id: UUID) -> Entity? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(entity)")
        do {
            let results = try CoreDataManaged.context.fetch(fetchRequest)
            var response: Entity?
            for result in results {
                if result.value(forKey: "id") as! UUID == id {
                    result.setValue(title, forKey: "title")
                    result.setValue(detail, forKey: "detail")
                    result.setValue(deadline, forKey: "deadline")
                    result.setValue(Date(), forKey: "createdTime")
                }
                response = (result as? Entity)!
            }
            try CoreDataManaged.context.save()
            return response
        } catch {
            let error = CoreDataError.insertError
            print("\(error)","during the deletion process.")
            return nil
        }
    }
    
    func delete<Entity>(entity: Entity.Type, id: UUID){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(entity)")
        do {
            let results = try CoreDataManaged.context.fetch(fetchRequest)
            for result in results {
                if result.value(forKey: "id") as! UUID == id {
                    CoreDataManaged.context.delete(result)
                    LocalNotificationManager.shared.scheduleNotification(item: result as! ToDo)
                }
            }
            do {
                try CoreDataManaged.context.save()
            } catch {
                let error = CoreDataError.insertError
                print("\(error)","during the deletion process.")
            }
        } catch {
            let error = CoreDataError.deleteError
            print("\(error)")
        }
    }
    
    func fetchAllItems<Entity>(entity: Entity.Type) -> [Entity]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(entity)")
        do {
            let toDoEntities = try CoreDataManaged.context.fetch(fetchRequest) as! [Entity]
            return toDoEntities
        } catch{
            let error = CoreDataError.fetchError
            print("\(error)")
            return nil
        }
    }
    
    func fetchSelectedItem<Entity>(entity: Entity.Type, id: UUID) -> Entity? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(entity)")
        var item: Entity?
        do {
            let results = try CoreDataManaged.context.fetch(fetchRequest)
            for result in results {
                if result.value(forKey: "id") as! UUID == id {
                    item = result as? Entity
                }
            }
        } catch {
            let error = CoreDataError.fetchError
            print("\(error)")
            return nil
        }
        return item
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
