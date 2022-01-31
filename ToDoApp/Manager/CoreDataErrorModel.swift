//
//  CoreDataErrorModel.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import Foundation

enum CoreDataError : String {
    case fetchError = "Could not fetch."
    case insertError = "Could not insert.Check your data"
    case updateError = "Could not update."
    case deleteError = "Could not delete"
}
