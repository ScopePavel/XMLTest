//
//  FullFeedBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import UIKit

final class FullFeedBuilder {
    func build(feedCellViewModel: FeedCellViewModel) -> FullFeedViewController? {
        let viewController = UIStoryboard(name: "FullFeed", bundle: Bundle(for: type(of: self))).instantiateInitialViewController() as? FullFeedViewController
        let viewModel = FullFeedViewModel(model: feedCellViewModel)
        viewController?.viewModel = viewModel
        return viewController
    }
}
