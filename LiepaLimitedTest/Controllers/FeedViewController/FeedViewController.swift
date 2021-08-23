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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBOutlet private weak var tableView: UITableView!

    @IBAction private func settingsAction(_ sender: Any) {
        viewModel?.showSettings { [weak self] in
            guard let self = self else { return }
            self.viewModel?.updateParsers()
            self.getData()
            self.getDataWithTimer()
        }
    }

    private func configTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self)
    }

    private func getData() {
        viewModel?.getData(complition: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }

    private func configViewModel() {
        // модель планируеться создаваться в апп делегате через код, для упрошения создаю тут так как инициализирую через сториборд стек контроллеров
        let parserConfigModels = [
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: .lenta,
                                                              urlString: "http://lenta.ru/rss"),
                                     isOn: UserDefaultsHelper().isLenta),
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: .gazeta,
                                                              urlString: "http://www.gazeta.ru/export/rss/lenta.xml"),
                                     isOn: UserDefaultsHelper().isGazeta)
        ]

        if let navigationController = navigationController {
            viewModel = FeedViewModel(parsersConfigurator: ParsersConfigurator(models: parserConfigModels),
                                      router: Router(navigationController: navigationController),
                                      dataBaseManager: DataBaseManager())
        }
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
        viewModel?.setFeed(index: indexPath.row)
    }
}


