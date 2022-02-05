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
    var itemsDetail: ToDo?
    
    let dataWorker: CoreDataManager
    init(dataWorker: CoreDataManager) {
        self.dataWorker = dataWorker
    }
    
    func presentToDoItemsDetail() {
        guard let itemsDetail = itemsDetail else { return }
        presenter?.presentToDoItemsDetail(output: DetailResponse.init(response: itemsDetail))
    }
    
    func addToDoItem(title: String, detail: String, deadline: Date) {
        dataWorker.insert(entity: ToDo.self,
                          title: title,
                          detail: detail,
                          deadline: deadline)
    }
    
    func editToDoItem(title: String, detail: String, deadline: Date, id: UUID){
        guard let itemsDetail = itemsDetail else { return }
        dataWorker.update(entity: ToDo.self, title: title, detail: detail, deadline: deadline, id: itemsDetail.id!)
    }
    
    func deleteToDoItem() {
        guard let itemsDetail = itemsDetail else { return }
        dataWorker.delete(entity: ToDo.self, id: itemsDetail.id!)
    }
}
