//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController, SettingViewControllerDelegate {
    private var answerItem: Answer?
    var dataModel: DataProvider!
    var apiInteractor: NetworkDataProvider!
    
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var reactionLabel: UILabel!
    @IBOutlet private weak var spiner: UIActivityIndicatorView!
        
    //MARK: - Motion methods
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = ""
        reactionLabel.text = "🔮"
        spiner.startAnimating()
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        answerLabel.text = "Shake your iPhone better"
        reactionLabel.text = "🧨"
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
    
    //MARK: - Helper methods
    
    private func configureTitles() {
        DispatchQueue.main.async { [self] in
            spiner.stopAnimating()
            guard let item = answerItem else {
                answerLabel.text = "Magic doesn't happen. You can add some in Settings."
                reactionLabel.text = "😢"
                return
            }
            answerLabel.text = item.answer
            let typeOfReaction = item.type
            if typeOfReaction == "Neutral" {
                reactionLabel.text = "🤔"
            } else if typeOfReaction == "Affirmative" {
                reactionLabel.text = "🙂"
            } else if typeOfReaction == "Contrary" {
                reactionLabel.text = "😶"
            }
        }
    }
    
    //MARK: - SettingViewController delegate
    
    func settingViewControllerDidCancel(_controller: SettingViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func settingViewController(_ controller: SettingViewController, didFinishAdding item: Answer) {
        dataModel.hardcodedAnswers.append(item)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingView" {
            let controller = segue.destination as! SettingViewController
            controller.delegate = self
        }
    }
}

