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
        case .presentToDoItems:
            let storyboard = UIStoryboard(name: "Items", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as! ItemsViewController
            viewController?.dismiss(animated: true, completion: nil)
//            destinationVC.interactor?.fetchToDoItems()
            _ = destinationVC.navigationController?.popViewController(animated: true)
        }
    }
}
