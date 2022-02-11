//
//  ItemsCell.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import UIKit

class ItemsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

