//
//  ItemDetailViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit

class ItemsDetailViewController: UIViewController {
    
    var interactor: ItemsDetailInteractorProtocol?
    var router: ItemsDetailRouterProtocol?

    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var detailText: UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
       setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.presentToDoItemsDetail()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let itemID = router?.dataStore?.itemID else {
            interactor?.addToDoItem(title: titleText.text!, detail: detailText.text, deadline: Date())
            router?.navigate(to: .presentItemsViewController)
            return
        }
        interactor?.editToDoItem(title: titleText.text!, detail: detailText.text, deadline: Date(), id: itemID)
        router?.navigate(to: .presentItemsViewController)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        interactor?.deleteToDoItem()
        router?.navigate(to: .presentItemsViewController)
    }
    
    private func setup(){
        let viewController = self
        let interactor = ItemsDetailInteractor(dataWorker: CoreDataManager())
        let presenter = ItemsDetailPresenter()
        let router = ItemsDetailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

extension ItemsDetailViewController: ItemsDetailViewProtocol {
    func presentToDoItemsDetail(viewModel: DetailViewPresentation) {
        self.titleText.text = viewModel.title
//        self.detailText.text = viewModel.
    }
}
