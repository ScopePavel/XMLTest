//
//  FullFeedBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import UIKit

final class FullFeedBuilder {
    func build(feedCellViewModel: FeedCellViewModel) -> UIViewController? {
        let viewController = UIStoryboard(
            name: "FullFeed",
            bundle: Bundle(for: type(of: self))).instantiateInitialViewController() as? FullFeedViewController
        let viewModel = FullFeedViewModelImpl(model: feedCellViewModel)
        viewController?.viewModel = viewModel
        return viewController
    }
}
