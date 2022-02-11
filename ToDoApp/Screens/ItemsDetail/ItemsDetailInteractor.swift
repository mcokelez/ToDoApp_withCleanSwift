//
//  ItemsDetailInteractor.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

class ItemsDetailInteractor: ItemsDetailInteractorProtocol, ItemsDetailDataStoreProtocol {
   
    var newToDoItem: ToDo?
    var presenter : ItemsDetailPresenterProtocol?
    var itemID: UUID?
    
    let dataWorker: CoreDataManager
    let notificationManager: LocalNotificationManager
    init(dataWorker: CoreDataManager, notificationManager: LocalNotificationManager) {
        self.dataWorker = dataWorker
        self.notificationManager = notificationManager
    }
    
    func presentToDoItemsDetail() {
        guard let itemID = itemID else { return }
        guard let item = getToDoItem(id: itemID) else { return }
        presenter?.presentToDoItemsDetail(output: DetailResponse.init(response: item))
    }
    
    func addToDoItem(title: String, detail: String, deadline: Date) -> ToDo? {
     return   dataWorker.insert(entity: ToDo.self,
                          title: title,
                          detail: detail,
                          deadline: deadline)
    }
    
    func editToDoItem(title: String, detail: String, deadline: Date, id: UUID) -> ToDo? {
      return  dataWorker.update(entity: ToDo.self, title: title, detail: detail, deadline: deadline, id: id)
    }
    
    func deleteToDoItem() {
        guard let itemID = itemID else { return }
        dataWorker.delete(entity: ToDo.self, id: itemID)
    }
    
    func getToDoItem(id: UUID) -> ToDo? {
        dataWorker.fetchSelectedItem(entity: ToDo.self, id: id)
    }
    
    func fetchNotificationSettings(_ view: UIViewController, item: ToDo){
        notificationManager.fetchNotificationSettings(view, item: item)
    }
}
