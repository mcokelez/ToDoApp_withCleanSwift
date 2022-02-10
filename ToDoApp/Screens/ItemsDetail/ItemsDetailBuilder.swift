//
//  ItemsDetailBuilder.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import Foundation
import UIKit

class ItemsDetailBuilder {
    static func build(_ viewController: ItemsDetailViewController){
        let viewController = viewController
        let interactor = ItemsDetailInteractor(dataWorker: CoreDataManager())
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
