//
//  ItemsDetailPresenter.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

class ItemsDetailPresenter: ItemsDetailPresenterProtocol {
    var viewController: ItemsDetailViewController?
    func presentToDoItemsDetail(output: DetailResponse) {
        viewController?.presentToDoItemsDetail(viewModel: DetailViewPresentation(title: output.response.title!, createdTime: output.response.createdTime!, detail: output.response.detail!, deadline: output.response.deadline!))
    }
}
