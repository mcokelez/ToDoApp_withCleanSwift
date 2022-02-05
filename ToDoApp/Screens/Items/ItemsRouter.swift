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
    
    func navigate(to route: ItemsRoute) {
        let storyboard = UIStoryboard(name: "ItemsDetail", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ItemsDetailViewController") as! ItemsDetailViewController
        
        switch route{
        case .presentToDoItemsDetail(let index):
            destinationVC.router?.dataStore?.itemsDetail = dataStore?.response[index]
        case .addNewToDoItem: break
        }
        self.viewController?.navigationController?.present(destinationVC, animated: true, completion: nil)
    }
}
