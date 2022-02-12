//
//  ItemsDetailBuilder.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import Foundation
import UIKit

// MARK: - Items Detail View Setup

class ItemsDetailBuilder {
    static func build(_ viewController: ItemsDetailViewController){
        let viewController = viewController
        let interactor = ItemsDetailInteractor(dataWorker: CoreDataManager(),
                                               notificationManager: LocalNotificationManager())
        let presenter = ItemsDetailPresenter()
        let router = ItemsDetailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
