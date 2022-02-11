//
//  ItemsModels.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

struct Response {
    let response: [ToDo]
}

struct ViewPresentation {
    var items: [ViewPresentation.ViewModel]
    
    struct ViewModel {
        let title: String
        let createdTime: Date
        let id: UUID
        let deadline: String
    }
}

