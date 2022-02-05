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
        tableView.register(UINib(nibName: "ItemsCell", bundle: nil), forCellReuseIdentifier: "itemsCell")
    }
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        router?.navigate(to: .addNewToDoItem)
    }
    
  
}

extension ItemsViewController: ItemsViewProtocol {
    
    func presentToDoItems(viewModel: ViewPresentation) {
        self.viewModel = viewModel
        self.tableView.reloadData()
        print(viewModel.items)
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigate(to: .presentToDoItemsDetail(indexPath.row))
    }
}

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as? ItemsCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel?.items[indexPath.row].title
        cell.createdDateLabel.text = viewModel?.items[indexPath.row].createdTime.dateAsPrettyString
        return cell
    }
    
    
}
