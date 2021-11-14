//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController {
    private var answerItem: Answer?
    var dataModel: DataProvider!
    var apiInteractor: NetworkDataProvider!

    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var reactionLabel: UILabel!
    @IBOutlet private weak var spiner: UIActivityIndicatorView!

    // MARK: - Motion methods

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = L10n.blankSpace
        reactionLabel.text = L10n.magicBallEmoji
        spiner.startAnimating()
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = L10n.shakeBetter
        reactionLabel.text = L10n.bombEmoji
        spiner.stopAnimating()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        apiInteractor.getAnswerData(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            if let answerItem = result {
                strongSelf.answerItem = answerItem
                strongSelf.configureTitles()
            } else {
                strongSelf.answerItem = strongSelf.dataModel.hardcodedAnswers.randomElement()
                strongSelf.configureTitles()
            }
        })
    }

    // MARK: - Helper methods

    private func configureTitles() {
        DispatchQueue.main.async { [self] in
            spiner.stopAnimating()
            guard let item = answerItem else {
                answerLabel.text = L10n.noMagic
                reactionLabel.text = L10n.cryingEmoji
                return
            }
            answerLabel.text = item.answer
            let typeOfReaction = item.type
            if typeOfReaction == L10n.neutral {
                reactionLabel.text = L10n.neutralEmoji
            } else if typeOfReaction == L10n.affirmative {
                reactionLabel.text = L10n.affirmativeEmoji
            } else if typeOfReaction == L10n.contrary {
                reactionLabel.text = L10n.contraryEmoji
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.Main.settingView.rawValue {
            guard let controller = segue.destination as? SettingViewController else { return }
            controller.delegate = self
        }
    }
}

// MARK: - SettingViewController delegate

extension ShakeViewController: SettingViewControllerDelegate {
    func settingViewControllerDidCancel(_ controller: SettingViewController) {
        navigationController?.popViewController(animated: true)
    }

    func settingViewController(_ controller: SettingViewController, didFinishAdding item: Answer) {
        dataModel.hardcodedAnswers.append(item)
        navigationController?.popViewController(animated: true)
    }
}
