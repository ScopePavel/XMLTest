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
        parsers.forEach { [weak self] parser in
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                complition?()
            }
        }
    }

    private var parsers: [ParserProtocol]
}
