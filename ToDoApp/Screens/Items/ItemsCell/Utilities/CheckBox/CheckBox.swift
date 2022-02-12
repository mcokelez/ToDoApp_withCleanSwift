//
//  CheckBox.swift
//  ToDoApp
//
//  Created by MAVİ on 4.02.2022.
//

import UIKit

// MARK: - If item did finished tapped the button, button view looks like this class

class CheckBox: UIButton {
    // Images
    var checkedImage = [UIImage(named: "blue"),
                       UIImage(named: "green"),
                       UIImage(named: "orange"),
                       UIImage(named: "purple"),
                       UIImage(named: "red"),
                       UIImage(named: "yellow")]
    let random = Int.random(in: 0...5)
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage[random], for: UIControl.State.normal)
            } else {
                self.setImage(UIImage?.init(UIImage.init(systemName: "circle")!), for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

   @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
