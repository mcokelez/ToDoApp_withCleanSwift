//
//  ItemsDetailModels.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import Foundation

struct DetailResponse {
    let response: ToDo
}

struct DetailViewPresentation {
    let title: String
    let createdTime: Date
    let detail: String
    let deadline: Date
}

