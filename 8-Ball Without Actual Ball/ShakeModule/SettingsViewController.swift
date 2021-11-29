//
//  SettingsViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    private let settingsViewModel: SettingsViewModel
    private let textField = UITextField()
    private let segmentedControlLabel = UILabel()
    private let segmentedControl = UISegmentedControl(
        items: [
            L10n.affirmativeEmoji,
            L10n.contraryEmoji,
            L10n.neutralEmoji
        ]
    )
    private let doneBarButton = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(done))
    private let cancelBarButton = UIBarButtonItem(
        title: L10n.cancel,
        style: .plain,
        target: self,
        action: #selector(cancel)
    )

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(segmentedControl)
        view.addSubview(segmentedControlLabel)
        doneBarButton.target = self
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.leftBarButtonItem = cancelBarButton
        doneBarButton.isEnabled = false
        textField.delegate = self
        configureAppearanceOfElements()
        configureConstraint()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK: - Actions

    @objc private func done() {
        let answer = textField.text!
        let segmentText = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!
        let type = configureTypeOfAnswer(for: segmentText)
        let presentableAnswer = PresentableAnswer(answer: answer, type: type)
        settingsViewModel.answerRecieved(presentableAnswer)
        navigationController?.popViewController(animated: true)
    }

    @objc private func cancel() {
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

    private func configureConstraint() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 45),
            segmentedControlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControlLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalTo: textField.heightAnchor)
        ])
    }

    private func configureAppearanceOfElements() {
        textField.borderStyle = .roundedRect
        if traitCollection.userInterfaceStyle == .light {
            view.backgroundColor = .systemGray5
        } else {
            textField.backgroundColor = .systemGray6
            view.backgroundColor = .black
        }
        textField.placeholder = L10n.writeYouVariant
        textField.clearButtonMode = .whileEditing
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        segmentedControlLabel.text = L10n.pickType
        segmentedControl.selectedSegmentIndex = 0
    }

    // MARK: - Initialization

    init(viewModel: SettingsViewModel) {
        settingsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Textfield delegate

extension SettingsViewController: UITextFieldDelegate {
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
