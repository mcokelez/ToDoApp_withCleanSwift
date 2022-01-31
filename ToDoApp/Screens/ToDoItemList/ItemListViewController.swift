//
//  ItemListViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit

class ItemListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchAll()
    }

    func fetchAll() {
        guard let toDoItems = CoreDataManager.shared.fetchAll(entity: ToDo.self) else {
            return
        }
        print(toDoItems.first?.title)
        print(toDoItems.first?.detail)
        print(toDoItems.first?.deadline)
        print(toDoItems.first?.createdTime)
        print(toDoItems.first?.id)
    }
    

}
