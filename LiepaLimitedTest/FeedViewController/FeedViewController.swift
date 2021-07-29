//
//  ViewController.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import UIKit

final class FeedViewController: UIViewController {

    var viewModel: FeedViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configViewModel()
        getData()
    }

    private func getData() {
        viewModel?.getData(complition: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }


    @IBOutlet private weak var tableView: UITableView!

    @IBAction private func settingsAction(_ sender: Any) {
        viewModel?.showSettings()
    }

    private func configTableView() {
        NotificationCenter.default.addObserver(self, selector: #selector(settings), name: LLNotifications.settings, object: nil)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self)
    }

    private func configViewModel() {

        if let navigationController = navigationController {
            viewModel = FeedViewModel(router: Router(navigationController: navigationController))
        }
        getDataWithTimer()
    }

    @objc private func settings(_ notification: Notification) {
        viewModel?.updateParsers()
        getData()
        getDataWithTimer()
    }

    private func getDataWithTimer() {
        viewModel?.getDataWithTimer(complition: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel?.feeds.count ?? 0 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseIdentifier) as? FeedCell,
            let model = viewModel?.feeds[safe: indexPath.row]
        else { return UITableViewCell() }

        cell.config(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? FeedCell else { return }
        tableView.beginUpdates()
        cell.descriptionNumberOfLines = (cell.descriptionNumberOfLines == 0) ? 3 : 0
        tableView.endUpdates()
    }
}


