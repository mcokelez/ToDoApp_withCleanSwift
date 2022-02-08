//
//  ItemsDetailInteractor.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

class ItemsDetailInteractor: ItemsDetailInteractorProtocol, ItemsDetailDataStoreProtocol {
   
    var newToDoItem: ToDo?
    var presenter : ItemsDetailPresenterProtocol?
    var itemID: UUID?
    
    let dataWorker: CoreDataManager
    init(dataWorker: CoreDataManager) {
        self.dataWorker = dataWorker
    }
    
    func presentToDoItemsDetail() {
        guard let itemID = itemID else { return }
        guard let item = getToDoItem(id: itemID) else { return }
        presenter?.presentToDoItemsDetail(output: DetailResponse.init(response: item))
    }
    
    func addToDoItem(title: String, detail: String, deadline: Date) {
        dataWorker.insert(entity: ToDo.self,
                          title: title,
                          detail: detail,
                          deadline: deadline)
    }
    
    func editToDoItem(title: String, detail: String, deadline: Date, id: UUID){
        dataWorker.update(entity: ToDo.self, title: title, detail: detail, deadline: deadline, id: id)
    }
    
    func deleteToDoItem() {
        guard let itemID = itemID else { return }
        dataWorker.delete(entity: ToDo.self, id: itemID)
    }
    
    func getToDoItem(id: UUID) -> ToDo? {
        dataWorker.fetchSelectedItem(entity: ToDo.self, id: id)
    }
}
