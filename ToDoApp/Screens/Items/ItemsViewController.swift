//
//  ItemsViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit

class ItemsViewController: UIViewController {
    
    // MARK: - Variables
    
    var interactor: ItemsInteractorProtocol?
    var router: ItemsRouterProtocol?
    var viewModel: ViewPresentation?
    var filteredViewModel : [ViewPresentation.ViewModel]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemsCell", bundle: nil), forCellReuseIdentifier: "itemsCell")
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .bottom
        tableView.backgroundView = imageView
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        return searchController
    }()
    
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
        navigationItem.searchController = searchController
        tableViewSetup()
        interactor?.requestNotificationAuthorised()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.fetchToDoItems()
    }
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        router?.navigate(to: .addNewToDoItem)
    }
    
    @IBAction func filterBarButtonTapped(_ sender: UIBarButtonItem) {
        interactor?.sortedToDoItems()
    }
    
    func tableViewSetup(){
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(tableView)
    }
    
    // MARK: - Variables for Search Bar
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterSearchText(searchText: String){
        filteredViewModel = viewModel?.items.filter({ (filteredItem: ViewPresentation.ViewModel) -> Bool in
            if isSearchBarEmpty {
                return false
                
            } else {
                return true && filteredItem.title.lowercased().contains(searchText.lowercased())
            }
        })
        self.tableView.reloadData()
    }
}

// MARK: - Items View Protocol

extension ItemsViewController: ItemsViewProtocol {
    func presentToDoItems(viewModel: ViewPresentation) {
        self.viewModel = viewModel
        self.tableView.reloadData()
        print(viewModel.items)
    }
}

// MARK: - Table View Delegate

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var id: UUID?
            if (self.searchController.isActive){
                id = filteredViewModel![indexPath.row].id
            }
            else {
                id = self.viewModel?.items[indexPath.row].id
            }
            interactor?.deleteToDoItem(id: id!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "selectedRow", sender: self)
       //  router?.navigate(to: .presentItemsDetailController(id!,indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedRow" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detail = segue.destination as! ItemsDetailViewController
            var id: UUID?
            if(self.searchController.isActive) {
                id = filteredViewModel![indexPath!.row].id
            }
            else {
                id = self.viewModel?.items[indexPath!.row].id
            }
            detail.router?.dataStore?.itemID = id
            self.tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Table View Data Source

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return (filteredViewModel?.count)!}
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as? ItemsCell else { return UITableViewCell() }
        let currentItem: ViewPresentation.ViewModel
        if isFiltering {
            currentItem = filteredViewModel![indexPath.row]
        }
        else {
            currentItem = (viewModel?.items[indexPath.row])!
        }
        cell.titleLabel.text = currentItem.title
        cell.createdDateLabel.text = "Created Time: " + currentItem.createdTime.dateAsPrettyString
        if currentItem.deadline != "01.02.2022" {
            cell.notificationImage.image = UIImage.init(systemName: "bell")
        } else {
            cell.notificationImage.image = nil
        }
        return cell
    }
}

// MARK: - Search Bar Result Updater

extension ItemsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar  = searchController.searchBar
        filterSearchText(searchText: searchBar.text!)
    }
}

