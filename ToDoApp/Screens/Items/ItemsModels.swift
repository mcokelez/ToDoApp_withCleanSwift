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
    let items: [ViewPresentation.ViewModel]
    
    struct ViewModel {
        let title: String
        let createdTime: Date
    }
}

