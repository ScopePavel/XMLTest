import Foundation

protocol NetworkManager {
    func getFeeds(complition: @escaping (([NewsWithSourceModel]) -> Void))
}

final class NetworkManagerImpl: NetworkManager {

    private let parsersConfigurator: ParsersConfiguratorProtocol
    private var feeds: [NewsWithSourceModel] = []
    private var group = DispatchGroup()

    init(parsersConfigurator: ParsersConfiguratorProtocol) {
        self.parsersConfigurator = parsersConfigurator
    }

    func getFeeds(complition: @escaping (([NewsWithSourceModel]) -> Void)) {
        feeds = []
        self.parsersConfigurator.getParsers().forEach { [weak self] parser in
            self?.group.enter()
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                self?.group.leave()
            }
        }

        self.group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            complition(self.feeds)
        }
    }
}
