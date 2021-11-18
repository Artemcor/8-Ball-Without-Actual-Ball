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
    private let answerLabel = UILabel()
    private let reactionLabel = UILabel()
    private let spiner = UIActivityIndicatorView(style: .large)

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        shakeViewModel.shouldAnimateLoadingStateHandler = { [weak self] shouldAnimate in
            self?.setAnimationEnabled(shouldAnimate)
        }
        view.addSubview(answerLabel)
        view.addSubview(reactionLabel)
        view.addSubview(spiner)
        configureViews()
        configureConstraints()
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
        DispatchQueue.main.async {
            if enebled {
                self.spiner.startAnimating()
            } else {
                self.spiner.stopAnimating()
            }
        }
    }

    private func configureConstraints() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        reactionLabel.translatesAutoresizingMaskIntoConstraints = false
        spiner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reactionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reactionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: answerLabel.topAnchor, constant: 10),
            reactionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureViews() {
        spiner.hidesWhenStopped = true
        spiner.color = .purple
        answerLabel.text = "Shake Your iPhone"
        reactionLabel.text = "📱"
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        reactionLabel.font = UIFont.systemFont(ofSize: 100)
    }
}
