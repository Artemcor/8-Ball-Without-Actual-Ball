//
//  HistoryViewController.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 24.11.2021.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

class HistoryViewController: UITableViewController {
    private let viewModel: HistoryViewModel

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.answerHistory
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAnswers(completion: { self.tableView.reloadData() })
    }

    // MARK: - Helper methods

    private func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.historyAnswers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: L10n.answerCell)
        let answer = viewModel.historyAnswers[indexPath.row]
        cell.textLabel?.text = answer.answer
        cell.detailTextLabel?.text = format(date: answer.date)
        return cell
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    // MARK: - Initialization

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
