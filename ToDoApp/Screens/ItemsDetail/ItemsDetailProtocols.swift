//
//  ItemsDetailProtocols.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import Foundation
import  UIKit

protocol ItemsDetailViewProtocol : NSObject {
    func presentToDoItemsDetail(viewModel: DetailViewPresentation)
}

protocol ItemsDetailInteractorProtocol {
    var newToDoItem: ToDo? { get set }
    func presentToDoItemsDetail()
    func addToDoItem(title: String, detail: String, deadline: Date) -> ToDo?
    func editToDoItem(title: String, detail: String, deadline: Date, id: UUID) -> ToDo?
    func getToDoItem(id: UUID) -> ToDo?
    func deleteToDoItem()
    func fetchNotificationSettings(_ view: UIViewController, item: ToDo)
    
}

protocol ItemsDetailDataStoreProtocol {
    var itemID: UUID? { get set}
}

protocol ItemsDetailPresenterProtocol {
    func presentToDoItemsDetail(output: DetailResponse)
}

enum ItemsDetailRoute {
    case presentItemsViewController
}

typealias ItemsDetailRouterProtocol = ItemsDetailRoutingProtocol & ItemsDetailDataPassingProtocol

protocol ItemsDetailRoutingProtocol {
    func navigate(to route: ItemsDetailRoute)
}

protocol ItemsDetailDataPassingProtocol {
    var dataStore: ItemsDetailDataStoreProtocol? { get set}
}

