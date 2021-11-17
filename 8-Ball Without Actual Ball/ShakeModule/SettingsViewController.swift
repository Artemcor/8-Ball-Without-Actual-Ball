//
//  SettingViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import UIKit

class SettingViewController: UITableViewController {
    weak var delegate: SettingViewControllerDelegate?
    var settingsViewModel: SettingsViewModel!

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var doneBarButton: UIBarButtonItem!
    @IBOutlet private weak var segmentedContorol: UISegmentedControl!

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        doneBarButton.isEnabled = false
        settingsViewModel = SettingsViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK: - Actions

    @IBAction private func done() {
        var presentableAnswer = PresentableAnswer()
        presentableAnswer.answer = textField.text!
        let segmentText = segmentedContorol.titleForSegment(at: segmentedContorol.selectedSegmentIndex)!
        presentableAnswer.type = configureTypeOfAnswer(for: segmentText)
//        delegate?.settingViewController(self, didFinishAdding: item)
        settingsViewModel.answerRecieved(presentableAnswer)
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func cancel() {
//        delegate?.settingViewControllerDidCancel(self)
        navigationController?.popViewController(animated: true)

    }

    // MARK: - Helper methods

    private func configureTypeOfAnswer(for string: String) -> String {
        var typeOfAnswer = L10n.blankSpace
        if string == L10n.neutralEmoji {
            typeOfAnswer = L10n.neutral
        } else if string == L10n.affirmativeEmoji {
            typeOfAnswer = L10n.affirmative
        } else if string == L10n.contraryEmoji {
            typeOfAnswer = L10n.contrary
        }
        return typeOfAnswer
    }
}

// MARK: - Textfield delegate

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
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
}

// MARK: - Table view data source

extension SettingViewController {
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
