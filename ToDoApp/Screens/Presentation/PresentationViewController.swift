//
//  PresentationViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 1.02.2022.
//

import UIKit

class PresentationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let storyBoard = UIStoryboard(name: "Items", bundle: nil)
            let destVC = storyBoard.instantiateInitialViewController()
            destVC?.modalPresentationStyle = .overFullScreen
            self.present(destVC!, animated: false, completion: nil)
        }
    }
}
