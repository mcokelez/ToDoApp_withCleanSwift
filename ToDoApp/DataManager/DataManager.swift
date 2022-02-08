//
//  DataManager.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

protocol DataManagerProtocol {
    func insert<Entity>(entity: Entity.Type, title: String, detail: String, deadline: Date)
    func update<Entity>(entity: Entity.Type, title: String, detail: String, deadline: Date, id: UUID)
    func delete<Entity>(entity: Entity.Type, id: UUID)
    func fetchAllItems<Entity>(entity: Entity.Type) -> [Entity]?
    func fetchSelectedItem<Entity>(entity: Entity.Type, id: UUID) -> Entity?
}
