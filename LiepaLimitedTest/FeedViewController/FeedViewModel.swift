//
//  FeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import Foundation

final class FeedViewModel: NSObject {

    var feeds: [FeedCellViewModel] = []

    init(parsers: [ParserProtocol]) {
        self.parsers = parsers
    }

    func getData(complition: (() -> ())?) {
        self.feeds = []
        parsers.forEach { [weak self] parser in
            group.enter()
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                self?.group.leave()
            }
        }


        group.notify(queue: .main) { [weak self] in
            complition?()
            print(self?.feeds.count)
        }
    }

    private let group = DispatchGroup()
    private var parsers: [ParserProtocol]
}
