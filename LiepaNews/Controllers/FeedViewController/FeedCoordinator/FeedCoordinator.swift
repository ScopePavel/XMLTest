import Foundation
import UIKit

protocol FeedOutput {
    func showSettings()
    func showFullFeed(model: FeedCellViewModel)
}

final class FeedCoordinator: CoordinatorProtocol {

    // MARK: - Internal Properties

    lazy var newslineModule = FeedsBuilder.build(self, parserConfigModels: parsersConfigurator)

    private var moduleInput: UIViewController { self.newslineModule }
    private lazy var parsersConfigurator: ParsersConfigurator = {
        let parserConfigModels = [
            ParsersConfiguratorModel(parser: ParserManager(id: "http://lenta.ru/rss")),
            ParsersConfiguratorModel(parser: ParserManager(id: "http://www.gazeta.ru/export/rss/lenta.xml")),
            ParsersConfiguratorModel(parser: ParserManager(id: "https://meduza.io/rss/all"))
        ]
        return ParsersConfigurator(models: parserConfigModels)
    }()

    // MARK: - Coordinator Protocol

    var nextCoordinator: CoordinatorProtocol?
    private(set) var resultClosures: FlowResultClosuresHolder = .empty
    var presentationType: CoordinatorPresentationType {
        return .custom
    }

    // MARK: - Flow

    func start() { }

    func finish(
        animated: Bool,
        result: CoordinatorFlowResult,
        resultClosures: FlowResultClosuresHolder
    ) { }
}

// MARK: - FeedOutput

extension FeedCoordinator: FeedOutput {

    func showFullFeed(model: FeedCellViewModel) {
        self.startDetailedNewsCoordinator(
            model: model,
            sourceViewController: self.newslineModule,
            resultClosures: .init(onFlowWillFinish: { result in
                self.resultClosures.onFlowWillFinish?(result)
            }, onFlowDidFinish: { result in
                self.resultClosures.onFlowDidFinish(result)
            }))
    }

    func showSettings() {
        self.startSettingsCoordinator(
            sourceViewController: self.newslineModule,
            parsersConfigurator: parsersConfigurator
        )
    }
}
