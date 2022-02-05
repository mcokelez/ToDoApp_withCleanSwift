//
//  ItemsDetailProtocols.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import Foundation

protocol ItemsDetailViewProtocol : NSObject {
    func presentToDoItemsDetail(viewModel: DetailViewPresentation)
}

protocol ItemsDetailInteractorProtocol {
    var newToDoItem: ToDo? { get set }
    func presentToDoItemsDetail()
    func addToDoItem(title: String, detail: String, deadline: Date)
    func editToDoItem(title: String, detail: String, deadline: Date, id: UUID)
    func deleteToDoItem()
    
}

protocol ItemsDetailDataStoreProtocol {
    var itemsDetail: ToDo? { get set}
}

protocol ItemsDetailPresenterProtocol {
    func presentToDoItemsDetail(output: DetailResponse)
}

enum ItemsDetailRoute {
    case presentToDoItems
}

typealias ItemsDetailRouterProtocol = ItemsDetailRoutingProtocol & ItemsDetailDataPassingProtocol

protocol ItemsDetailRoutingProtocol {
    func navigate(to route: ItemsDetailRoute)
}

protocol ItemsDetailDataPassingProtocol {
    var dataStore: ItemsDetailDataStoreProtocol? { get set}
}

