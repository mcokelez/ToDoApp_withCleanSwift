//
//  Constant.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import Foundation
import CoreData

//MARK: - Core Data context

class CoreDataManaged : NSManagedObjectContext {
    static let context  = CoreDataManager.shared.persistentContainer.viewContext
}

