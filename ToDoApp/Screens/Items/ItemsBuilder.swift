//
//  ItemsBuilder.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation
import UIKit

// MARK: - View Controller Setup

class ItemsBuilder {
    static func build(_ viewController: ItemsViewController) -> Void{
        let viewController = viewController
        let interactor = ItemsInteractor(dataWorker: CoreDataManager(),
                                         notificationManager: LocalNotificationManager())
        let presenter = ItemsPresenter()
        let router = ItemsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
