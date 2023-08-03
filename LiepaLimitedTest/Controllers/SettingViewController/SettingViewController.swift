//
//  SettingViewController.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class SettingViewController: UIViewController {

    var viewModel: SettingViewModel?
//    @IBOutlet private weak var timeIntervalTextField: UITextField!
//    @IBOutlet private weak var tableView: UITableView!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(SettingCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        return tableView
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return button
    }()

    private lazy var timeIntervalTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.placeholder = "Time Interval"
        textField.addTarget(self, action: #selector(timeIntervalChangedAction), for: .editingChanged)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configView()
    }

    private func setup() {
        view.backgroundColor = .white
        view.bui_addSubviews(
            editButton,
            timeIntervalTextField,
            tableView
        )

        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            editButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            editButton.bottomAnchor.constraint(equalTo: timeIntervalTextField.topAnchor, constant: -16),
            timeIntervalTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            timeIntervalTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            timeIntervalTextField.heightAnchor.constraint(equalToConstant: 20),
            timeIntervalTextField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @IBAction private func doneAction(_ sender: Any) {
        viewModel?.done()
    }

    @objc private func timeIntervalChangedAction(_ sender: UITextField) {
        viewModel?.timeInterval = Double(sender.text ?? "")
    }

    private func configView() {
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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingCell.reuseIdentifier,
                for: indexPath
            ) as? SettingCell,
            let parser = viewModel?.parsersConfigurator.allParsers()[safe: indexPath.row]
        else { return UITableViewCell() }
        cell.config(parser: parser)
        return cell
    }
}
