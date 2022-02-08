//
//  ItemsInteractor.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

class ItemsInteractor : ItemsInteractorProtocol, ItemsDataStoreProtocol{
    
    var presenter: ItemsPresenterProtocol?
    var itemsArray : [ToDo] = []
    
    let dataWorker: CoreDataManager
    init(dataWorker: CoreDataManager) {
        self.dataWorker = dataWorker
    }
    
    func fetchToDoItems() {
        guard let response = dataWorker.fetchAllItems(entity: ToDo.self) else { return }
        self.itemsArray = response
        self.presenter?.presentToDoItems(output: Response.init(response: self.itemsArray))
    }
    
    
    func filterItems(with createdTime: Int) {
     
    }
    
    func searchItems(with character: String) {
       
    }
    
}
