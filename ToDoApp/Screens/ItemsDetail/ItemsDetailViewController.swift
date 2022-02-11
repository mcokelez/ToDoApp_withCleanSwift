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
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ItemsDetailBuilder.build(self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ItemsDetailBuilder.build(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailText.text = "Details..."
        detailText.textColor = UIColor.lightGray
        deadlineDefaultValue()
        interactor?.presentToDoItemsDetail()
    }
    
    func deadlineDefaultValue() {
        deadlinePicker.isHidden = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd.MM.yyyy"
        let date = dateFormatter.date(from: "01.02.2022")
        deadlinePicker.date = date!
    }
    
    @IBAction func didDeadlineButtonTap(_ sender: UIButton) {
        deadlinePicker.isHidden = false
    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        guard let itemID = router?.dataStore?.itemID else {
            guard let text = titleText.text, !text.isEmpty else {
                didTitleEmpty()
                return
            }
            let item = interactor?.addToDoItem(title: titleText.text!, detail: detailText.text, deadline: deadlinePicker.date)
            if item?.deadline?.dateAsPrettyString != "01.02.2022"{
                interactor?.fetchNotificationSettings(self, item: item!)
            }
            router?.navigate(to: .presentItemsViewController)
            return
        }
        let item = interactor?.editToDoItem(title: titleText.text!, detail: detailText.text, deadline: deadlinePicker.date, id: itemID)
        if item?.deadline?.dateAsPrettyString != "01.02.2022"{
            interactor?.fetchNotificationSettings(self, item: item!)
        }
        router?.navigate(to: .presentItemsViewController)
    }
    
    func didTitleEmpty() {
        let alert = UIAlertController(title: "Required", message: "Title can not be empty!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ItemsDetailViewController: ItemsDetailViewProtocol {
    func presentToDoItemsDetail(viewModel: DetailViewPresentation) {
        self.titleText.text = viewModel.title
        self.detailText.text = viewModel.detail
        if viewModel.deadline.dateAsPrettyString != "01.02.2022" {
            self.deadlinePicker.isHidden = false
            self.deadlinePicker.date = viewModel.deadline
        } else {
            self.deadlinePicker.isHidden = true
        }
    }
}

extension ItemsDetailViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Details..."
            textView.textColor = UIColor.lightGray
        }
    }
}
