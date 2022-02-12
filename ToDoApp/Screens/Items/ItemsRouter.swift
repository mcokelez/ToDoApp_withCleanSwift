//
//  ItemsRouter.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

class ItemsRouter : ItemsRouterProtocol {
    
    weak var viewController: ItemsViewController?
    var dataStore: ItemsDataStoreProtocol?
    
    // MARK: - Items Router Protocol
    
    func navigate(to route: ItemsRoute) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ItemsDetailViewController") as! ItemsDetailViewController
        
        switch route{
        case .presentItemsDetailController(let id, let index):
            dataStore?.itemsArray[index].id = id
            destinationVC.router?.dataStore?.itemID = dataStore?.itemsArray[index].id
        case .addNewToDoItem: break
        }
        self.viewController?.navigationController?.present(destinationVC, animated: true, completion: nil)
    }
}

