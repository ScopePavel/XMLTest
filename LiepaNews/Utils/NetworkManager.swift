import Foundation

protocol NetworkManager {
    func getFeeds(complition: @escaping (([FeedModel]) -> Void))
}

final class NetworkManagerImpl: NetworkManager {

    private let parsersConfigurator: ParsersConfiguratorProtocol
    private var feeds: [FeedModel] = []

    init(parsersConfigurator: ParsersConfiguratorProtocol) {
        self.parsersConfigurator = parsersConfigurator
    }

    func getFeeds(complition: @escaping (([FeedModel]) -> Void)) {
        feeds = []
        let group = DispatchGroup()
        self.parsersConfigurator.getParsers().forEach { [weak self] parser in
            group.enter()
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            complition(self.feeds)
        }
    }
}
