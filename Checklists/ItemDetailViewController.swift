//
//  AddItemViewController.swift
//  Checklists
//
//  Created by jeni on 1/23/22.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(
    _ controller: ItemDetailViewController)
    func addItemViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: ChecklistItem
    )
    func addItemViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem
    )
} //defines delegate protocol to communicate b/w controllers

class ItemDetailViewController: UITableViewController,
                             UITextFieldDelegate {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    //MARK: - Actions
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        if let item = itemToEdit {
        item.text = textField.text!
        delegate?.addItemViewController(
            self, didFinishAdding: item)
        } else {
            let item = ChecklistItem ()
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
        }
   
    //MARK: - Table View Delegates
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
    //^^disables selection with 'nil' return

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    //MARK: - Text Field Delegates
    func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
    ) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    
    func textFieldShouldClear(_ textField: UITextField
    ) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
        
    }
    
}



