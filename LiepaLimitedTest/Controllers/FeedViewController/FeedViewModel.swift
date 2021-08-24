//
//  FeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import Foundation

final class FeedViewModel {

    var feeds: [FeedCellViewModel] = []

    init(parsersConfigurator: ParsersConfiguratorProtocol, router: Router, dataBaseManager: DataBaseManagerProtocol) {
        self.parsersConfigurator = parsersConfigurator
        self.router = router
        self.dataBaseManager = dataBaseManager
        self.updateParsers()
        self.updateViewdFeeds()
    }

    func getDataWithTimer(complition: (() -> ())?) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: UserDefaultsHelper().timeIntervalForTimer, repeats: true) {  [weak self] _ in
            self?.getData(complition: complition)
        }
    }

    func getData(complition: (() -> ())?) {
        self.feeds = []
        self.parsers.forEach { [weak self] parser in
            self?.group.enter()
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                self?.group.leave()
            }
        }


        self.group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.feeds = self.feeds.enumerated().compactMap { (index, feed) -> FeedCellViewModel? in
                if self.viewedFeeds.contains(feed.guId ?? "") {
                    var newFeed = feed
                    newFeed.isView = true
                    return newFeed
                }
                return feed
            }.sorted(by: { $0.date > $1.date })
            complition?()
        }
    }

    func showSettings(onClose: @escaping (()->())) {
        router.showSettings(parsersConfigurator: parsersConfigurator, onClose: onClose)
    }

    func showFullFeed(model: FeedCellViewModel) {
        router.showFullFeed(feedCellViewModel: model)
    }

    func updateParsers() {
        parsers = parsersConfigurator.getParsers()
    }

    func setFeed(index: Int) {
        guard let model = feeds[safe: index] else { return }
        if let guId = feeds[safe: index]?.guId {
            viewedFeeds.append(guId)
            dataBaseManager.setFeed(model: model)
            feeds[index].isView = true
            showFullFeed(model: model)
        }
    }

    private var parsersConfigurator: ParsersConfiguratorProtocol
    private var viewedFeeds: [String] = []
    private let dataBaseManager: DataBaseManagerProtocol
    private var timer: Timer?
    private let router: Router
    private let group = DispatchGroup()
    private var parsers: [ParserProtocol] = []

    private func updateViewdFeeds() {
        viewedFeeds = dataBaseManager.getGuids()
    }
}
