//
//  ShakeViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

class ShakeViewController: UIViewController, SettingViewControllerDelegate {
    var answerItem: Answer?
    var dataModel: AnswerDataModel!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var reactionLabel: UILabel!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
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
        getAnswerData()
    }
    
    //MARK: - Helper methods
    
    func getAnswerData() {
        guard let string = "https://8ball.delegator.com/magic/JSON/<question_string>".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let url = URL(string: string) {
            let task = URLSession.shared.dataTask(with: url){ [self] data, response, error in
                guard let data = data else {
                    self.answerItem = dataModel.hardcodedAnswers.randomElement()
                    self.configureTitles()
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let itemModel = try decoder.decode(AnswerModel.self, from: data)
                    self.answerItem = itemModel.answerItem
                    self.configureTitles()
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    func configureTitles() {
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

