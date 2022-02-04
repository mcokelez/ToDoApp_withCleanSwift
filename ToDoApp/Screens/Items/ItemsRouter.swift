//
//  ItemsRouter.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

class ItemsRouter : ItemsRouterProtocol {
    
    weak var viewController: ItemsViewProtocol?
    var dataStore: ItemsDataStoreProtocol?
    
    func navigate(to route: ItemsRoute) {
       
    }
}
