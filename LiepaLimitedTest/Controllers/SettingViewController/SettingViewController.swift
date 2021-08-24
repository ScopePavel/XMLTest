//
//  SettingViewController.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class SettingViewController: UIViewController {

    var viewModel: SettingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    @IBOutlet private weak var timeIntervalTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    @IBAction private func doneAction(_ sender: Any) {
        viewModel?.done()
    }

    @IBAction private func timeIntervalChangedAction(_ sender: UITextField) {
        viewModel?.timeInterval = Double(sender.text ?? "")
    }

    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        if let timeInterval = viewModel?.timeInterval {
            timeIntervalTextField.text = "\(timeInterval)"
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.parsersConfigurator.allParsers().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell,
            let parser = viewModel?.parsersConfigurator.allParsers()[safe: indexPath.row]
        else { return UITableViewCell() }
        cell.config(parser: parser)
        return cell
    }
}
