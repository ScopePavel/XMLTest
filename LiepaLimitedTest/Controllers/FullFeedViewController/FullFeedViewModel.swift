//
//  FullFeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import Foundation

protocol FullFeedViewModel {
    var cellModel: FeedCellViewModel? { get set }
}

final class FullFeedViewModelImpl: FullFeedViewModel {

    var cellModel: FeedCellViewModel?

    init(model: FeedCellViewModel) {
        self.cellModel = model
    }
}
