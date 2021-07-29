//
//  FeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import Foundation



final class FeedViewModel {

    var feeds: [FeedCellViewModel] = []

    init(router: Router) {
        self.router = router
        self.updateParsers()
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
            self?.feeds = self?.feeds.sorted(by: { $0.date > $1.date }) ?? []
            complition?()
            print(self?.feeds.count)
            print(Date())
        }
    }

    func showSettings() {
        router.showSettings()
    }

    func updateParsers() {
        parsers = []
        if UserDefaultsHelper().isLenta {
            parsers.append(ParserManagerTwo(urlString: "http://lenta.ru/rss"))
        }
        if UserDefaultsHelper().isGazeta {
            parsers.append(ParserManagerTwo(urlString: "http://www.gazeta.ru/export/rss/lenta.xml"))
        }
    }

    private var timer: Timer?
    private let router: Router
    private let group = DispatchGroup()
    private var parsers: [ParserProtocol] = []
}
