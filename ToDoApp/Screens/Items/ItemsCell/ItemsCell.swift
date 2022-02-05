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
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkButtonTapped(_ sender: CheckBox) {
//        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: titleLabel.text!)
//            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
//        titleLabel.attributedText = attributeString
    }
    
}

