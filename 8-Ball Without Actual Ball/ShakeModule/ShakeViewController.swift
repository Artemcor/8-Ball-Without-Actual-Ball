//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController, ShakeViewModelDelegate {
    private let shakeViewModel: ShakeViewModel
    private let answerLabel = UILabel()
    private let reactionLabel = UILabel()
    private let answersCounterLabel = UILabel()
    private var isFirstTime = true
    var isShakeAllowed = true
    var timeOfShake = Date()

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(answerLabel)
        view.addSubview(reactionLabel)
        view.addSubview(answersCounterLabel)
        configureViews()
        configureTitles()
        configureConstraints()
        configureSecureInformationTitle()
        let settingsBarButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonPressed)
        )
        navigationItem.rightBarButtonItem = settingsBarButton
        navigationController?.navigationBar.tintColor = .systemPurple
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isShakeAllowed {
            animationStarts()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstTime {
            lounchAnimation()
            isFirstTime = false
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isShakeAllowed {
            animationEnds()
        }
    }

    // MARK: - Motion methods

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        motionBeganConfiguration()
        if isShakeAllowed {
            timeOfShake = Date()
            animationStarts()
        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = L10n.shakeBetter
        reactionLabel.text = L10n.bombEmoji
        animationEnds()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if isShakeAllowed {
            shakeViewModel.shakeDetected()
        }
    }

    // MARK: - Helper methods

    func motionBeganConfiguration() {
        answerLabel.text = L10n.blankSpace
        reactionLabel.text = L10n.magicBallEmoji
        animationOfLabel(with: answerLabel)
    }

    func configureTitles(with answer: PresentableAnswer?) {
        animationEnds()
        guard let item = answer else {
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
        configureSecureInformationTitle()
        animationOfLabel(with: answerLabel)
        animationOfLabel(with: reactionLabel)
    }

    func configureSecureInformationTitle() {
        answersCounterLabel.text = "Shake counter: \(shakeViewModel.fetchShakeCounter())"
    }

    func configureTitles() {
        if isFirstTime {
            answersCounterLabel.textColor = .gray
            reactionLabel.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
            reactionLabel.alpha = 0.0
            answerLabel.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
            answerLabel.alpha = 0.0
        }
    }

    private func configureConstraints() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        reactionLabel.translatesAutoresizingMaskIntoConstraints = false
        answersCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraintHeightOfSecureLabel = NSLayoutConstraint(
            item: answersCounterLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: reactionLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        constraintHeightOfSecureLabel.priority = UILayoutPriority(500)
        NSLayoutConstraint.activate([
            answersCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            answersCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reactionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reactionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: answerLabel.topAnchor, constant: 10),
            reactionLabel.topAnchor.constraint(equalTo: answersCounterLabel.bottomAnchor, constant: 30),
            constraintHeightOfSecureLabel
        ])
    }

    private func configureViews() {
        answerLabel.text = L10n.shake
        answerLabel.numberOfLines = 6
        answerLabel.textAlignment = .center
        reactionLabel.text = L10n.iPhoneEmoji
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        reactionLabel.font = UIFont.systemFont(ofSize: 100)
    }

    @objc private func settingsButtonPressed() {
        let settingsViewController = Wireframe().buildSettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    // MARK: - Initialization

    init(viewModel: ShakeViewModel) {
        shakeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Animation functions

    private func animationStarts() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.repeat, .autoreverse, .curveEaseInOut],
            animations: {
                self.reactionLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            },
            completion: nil
        )
    }

    private func animationEnds() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.reactionLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: nil
        )
    }
    private func animationOfLabel(with label: UILabel) {
        UIView.transition(
            with: label,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }

    private func lounchAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn)
        animator.addAnimations {
            self.reactionLabel.alpha = 1.0
            self.answerLabel.alpha = 1.0
        }
        animator.addAnimations({
            self.reactionLabel.transform = .identity
            self.answerLabel.transform = .identity
        }, delayFactor: 0.33)
        animator.startAnimation()
    }
}
