//
//  FeedBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 24.08.2021.
//

import UIKit

final class FeedsBuilder {
    func build(parsersConfigurator: ParsersConfigurator, router: Router, dataBaseManager: DataBaseManagerProtocol) -> FeedViewController? {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController

        viewController?.viewModel = FeedViewModel(parsersConfigurator: parsersConfigurator,
                                                  router: router,
                                                  dataBaseManager: dataBaseManager)
        return viewController
    }
}
