//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController, ViewModelDelegate {
    var answerItem: PresentableAnswer?
    private var shakeViewModel: ShakeViewModel!
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
        let settingsBarButton = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(settingsButtonPressed)
        )
        navigationItem.rightBarButtonItem = settingsBarButton
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
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            reactionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reactionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: answerLabel.topAnchor, constant: 10.0),
            reactionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureViews() {
        spiner.hidesWhenStopped = true
        spiner.color = .purple
        answerLabel.text = L10n.shake
        answerLabel.numberOfLines = 6
        answerLabel.textAlignment = .center
        reactionLabel.text = L10n.iPhoneEmoji
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        reactionLabel.font = UIFont.systemFont(ofSize: 100)
    }

    @objc private func settingsButtonPressed() {
        let settingsViewController = Wireframe.buildSettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    // MARK: - Initialization

    init(viewModel: ShakeViewModel) {
        super.init(nibName: nil, bundle: nil)
        shakeViewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
