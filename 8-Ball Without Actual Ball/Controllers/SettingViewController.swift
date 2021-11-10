//
//  SettingViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import UIKit

class SettingViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: SettingViewControllerDelegate?
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var doneBarButton: UIBarButtonItem!
    @IBOutlet private weak var segmentedContorol: UISegmentedControl!
  
    //MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        doneBarButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction private func done() {
        let item = Answer()
        item.answer = textField.text!
        let segmentText = segmentedContorol.titleForSegment(at: segmentedContorol.selectedSegmentIndex)!
        item.type = configureTypeOfAnswer(for: segmentText)
        delegate?.settingViewController(self, didFinishAdding: item)
    }
    
    @IBAction private func cancel() {
        delegate?.settingViewControllerDidCancel(_controller: self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //MARK: - Textfield delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
        
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Helper methods
    
    private func configureTypeOfAnswer(for string: String) -> String {
        var typeOfAnswer = ""
        if string == "🤔" {
            typeOfAnswer = "Neutral"
        } else if string == "🙂" {
            typeOfAnswer = "Affirmative"
        } else if string == "😶" {
            typeOfAnswer = "Contrary"
        }
        return typeOfAnswer
    }
}
