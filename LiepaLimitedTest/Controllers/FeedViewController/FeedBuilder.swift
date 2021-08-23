//
//  FeedBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 24.08.2021.
//

import UIKit

final class FeedsBuilder {
    func build(viewModel: FeedViewModel) -> FeedViewController? {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        viewController?.viewModel = viewModel
        return viewController
    }
}
