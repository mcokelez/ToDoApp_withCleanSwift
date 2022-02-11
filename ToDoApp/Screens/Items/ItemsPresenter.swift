//
//  ItemsPresenter.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

class ItemsPresenter : ItemsPresenterProtocol {
    weak var viewController: ItemsViewProtocol?
    var viewModel : [ViewPresentation.ViewModel] = []
    func presentToDoItems(output: Response) {
        viewModel.removeAll()
        for item in output.response {
            viewModel.append(ViewPresentation.ViewModel(title: item.title!,
                                                        createdTime: item.createdTime!,
                                                        id: item.id!,
                                                        deadline: (item.deadline?.dateAsPrettyString)!))
        }
        viewController?.presentToDoItems(viewModel: ViewPresentation(items: viewModel))
    }
    
}
