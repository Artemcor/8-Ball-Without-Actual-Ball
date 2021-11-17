//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController, ViewModelDelegate {
    var answerItem: PresentableAnswer?
    var shakeViewModel: ShakeViewModel!

    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var reactionLabel: UILabel!
    @IBOutlet private weak var spiner: UIActivityIndicatorView!

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        shakeViewModel.shouldAnimateLoadingStateHandler = { [weak self] shouldAnimate in
            self?.setAnimationEnabled(shouldAnimate)
        }
    }

    // MARK: - Motion methods

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = L10n.blankSpace
        reactionLabel.text = L10n.magicBallEmoji
        setAnimationEnabled(true)
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = L10n.shakeBetter
        reactionLabel.text = L10n.bombEmoji
        setAnimationEnabled(false)
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shakeViewModel.shakeDetected()
    }

    // MARK: - Helper methods

    func configureTitles() {
        DispatchQueue.main.async {
            guard let item = self.answerItem else {
                self.answerLabel.text = L10n.noMagic
                self.reactionLabel.text = L10n.cryingEmoji
                return
            }
            self.answerLabel.text = item.answer
            let typeOfReaction = item.type
            if typeOfReaction == L10n.neutral {
                self.reactionLabel.text = L10n.neutralEmoji
            } else if typeOfReaction == L10n.affirmative {
                self.reactionLabel.text = L10n.affirmativeEmoji
            } else if typeOfReaction == L10n.contrary {
                self.reactionLabel.text = L10n.contraryEmoji
            }
        }
    }

    private func setAnimationEnabled(_ enebled: Bool) {
        DispatchQueue.main.async { [self] in
            if enebled {
                spiner.startAnimating()
            } else {
                spiner.stopAnimating()
            }
        }
    }
}
