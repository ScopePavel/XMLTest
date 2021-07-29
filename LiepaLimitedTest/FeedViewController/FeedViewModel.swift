//
//  FeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import Foundation



final class FeedViewModel: NSObject {

    var feeds: [FeedCellViewModel] = []

    init(parsers: [ParserProtocol], router: Router) {
        self.parsers = parsers
        self.router = router
    }

    func getData(complition: (() -> ())?) {
        _ = Timer.scheduledTimer(withTimeInterval: UserDefaultsHelper().timeIntervalForTimer, repeats: true) {  [weak self] _ in
            guard let self = self else { return }
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
    }

    func showSettings() {
        router.showSettings()
    }

    private let router: Router
    private let group = DispatchGroup()
    private var parsers: [ParserProtocol]
}
