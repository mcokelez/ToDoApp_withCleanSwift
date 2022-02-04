//
//  ItemsViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit

class ItemsViewController: UIViewController {
    
    var interactor: ItemsInteractorProtocol?
    var router: ItemsRouterProtocol?
    var viewModel: ViewPresentation?
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ItemsBuilder.build(self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ItemsBuilder.build(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchToDoItems()
    }
  
}

extension ItemsViewController: ItemsViewProtocol {
    
    func presentToDoItems(viewModel: ViewPresentation) {
        self.viewModel = viewModel
        tableView.reloadData()
        print(viewModel.items)
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.viewModel?.items[indexPath.row].title
        return cell!
    }
    
    
}
