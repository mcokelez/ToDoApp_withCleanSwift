//
//  ItemsProtocols.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

protocol ItemsViewProtocol : NSObject {
    func presentToDoItems(viewModel: ViewPresentation)
}

protocol ItemsInteractorProtocol {
    func fetchToDoItems()
    func deleteToDoItem(id: UUID)
    func sortedToDoItems()
    func requestNotificationAuthorised()
}

protocol ItemsDataStoreProtocol {
    var itemsArray: [ToDo] { get set}
}

protocol ItemsPresenterProtocol {
    func presentToDoItems(output: Response)
}

enum ItemsRoute {
    case presentItemsDetailController(_ id: UUID, _ index: Int)
    case addNewToDoItem
}

typealias ItemsRouterProtocol = ItemsRoutingProtocol & ItemsDataPassingProtocol

protocol ItemsRoutingProtocol {
    func navigate(to route: ItemsRoute)
}

protocol ItemsDataPassingProtocol {
    var dataStore: ItemsDataStoreProtocol? { get }
}

