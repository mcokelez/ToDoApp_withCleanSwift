//
//  ItemDetailViewController.swift
//  ToDoApp
//
//  Created by MAVİ on 31.01.2022.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    static let toDoItem: [ToDo] = []
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var detailtext: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleText.text else {
            return /**UIalert  necessary area*/
        }
        guard let detail = detailtext.text else { return }
        
        save(title: title, detail: detail)
        
        
    }
    
    
    func save( title: String, detail: String){
        CoreDataManager.shared.insert(entity: ToDo.self,title: title, detail: detail, deadline: Date())
    }
    /*
     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
