//
//  FullFeedViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import Foundation

final class FullFeedViewModel {

    var cellModel: FeedCellViewModel?

    init(model: FeedCellViewModel) {
        self.cellModel = model
    }
}
