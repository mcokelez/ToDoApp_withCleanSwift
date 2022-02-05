//
//  Date+Extension.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import UIKit

extension Date {
    var dateAsPrettyString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yyyy"
        return dateFormat.string(from: self)
    }
}

