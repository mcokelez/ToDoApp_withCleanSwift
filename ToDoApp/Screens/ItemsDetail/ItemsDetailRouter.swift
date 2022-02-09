//
//  ItemsDetailRouter.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

class ItemsDetailRouter: ItemsDetailRouterProtocol {
    
    var viewController: ItemsDetailViewController?
    var dataStore: ItemsDetailDataStoreProtocol?
    
    func navigate(to route: ItemsDetailRoute) {
        switch route {
        case .presentItemsViewController:
            self.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
