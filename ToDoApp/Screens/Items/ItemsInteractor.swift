//
//  ItemsInteractor.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

class ItemsInteractor : ItemsInteractorProtocol, ItemsDataStoreProtocol{
    
    var presenter: ItemsPresenterProtocol?
    var itemsArray : [ToDo] = []
    
    let dataWorker: CoreDataManager
    let notificationManager: LocalNotificationManager
    init(dataWorker: CoreDataManager, notificationManager: LocalNotificationManager) {
        self.dataWorker = dataWorker
        self.notificationManager = notificationManager
    }
    // MARK: - Items Interactor Protocols
    
    func fetchToDoItems() {
        guard let response = dataWorker.fetchAllItems(entity: ToDo.self) else { return }
        self.itemsArray = response
        self.presenter?.presentToDoItems(output: Response.init(response: self.itemsArray))
    }
    
    func deleteToDoItem(id: UUID) {
        dataWorker.delete(entity: ToDo.self, id: id)
        fetchToDoItems()
    }
    
    func sortedToDoItems() {
        guard let response = dataWorker.fetchAllItems(entity: ToDo.self) else { return }
        self.itemsArray = response.sorted(by: { $0.createdTime! > $1.createdTime! })
        self.presenter?.presentToDoItems(output: Response.init(response: self.itemsArray))
    }
    
    func requestNotificationAuthorised() {
        notificationManager.requestAuthorization()
    }
}
