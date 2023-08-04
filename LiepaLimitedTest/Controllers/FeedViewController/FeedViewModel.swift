import Foundation

protocol FeedViewModel {
    var feeds: [FeedCellViewModel] { get set }

    func getDataWithTimer(complition: (() -> Void)?)
    func getData(complition: (() -> Void)?)
    func showSettings(onClose: @escaping (() -> Void))
    func showFullFeed(model: FeedCellViewModel)
    func updateParsers()
    func setFeed(index: Int)
}

final class FeedViewModelImpl: FeedViewModel {

    var feeds: [FeedCellViewModel] = []
    private var parsersConfigurator: ParsersConfiguratorProtocol
    private var viewedFeeds: [FeedCellViewModel] = []
    private let dataBaseManager: DataBaseManagerProtocol
    private var timer: Timer?
    private let router: Router
    private let group = DispatchGroup()
    private var parsers: [ParserProtocol] = []

    init(parsersConfigurator: ParsersConfiguratorProtocol, router: Router, dataBaseManager: DataBaseManagerProtocol) {
        self.parsersConfigurator = parsersConfigurator
        self.router = router
        self.dataBaseManager = dataBaseManager
        self.updateParsers()
        self.updateViewdFeeds()
    }

    func getDataWithTimer(complition: (() -> Void)?) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: UserDefaultsHelper().timeIntervalForTimer,
            repeats: true
        ) {  [weak self] _ in
            self?.getData(complition: complition)
        }
    }

    func getData(complition: (() -> Void)?) {
        self.feeds = []
        self.parsers.forEach { [weak self] parser in
            self?.group.enter()
            parser.getData { [weak self] feedsFromParser in
                self?.feeds.append(contentsOf: feedsFromParser)
                self?.group.leave()
            }
        }

        self.group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.feeds = self.feeds.enumerated().compactMap { _, feed -> FeedCellViewModel? in
                if self.viewedFeeds.contains(feed) {
                    var newFeed = feed
                    newFeed.isView = true
                    return newFeed
                }
                return feed
            }.sorted(by: { $0.date > $1.date })
            complition?()
        }
    }

    func showSettings(onClose: @escaping (() -> Void)) {
        router.showSettings(parsersConfigurator: parsersConfigurator, onClose: onClose)
    }

    func showFullFeed(model: FeedCellViewModel) {
        router.showFullFeed(feedCellViewModel: model)
    }

    func updateParsers() {
        parsers = parsersConfigurator.getParsers()
    }

    func setFeed(index: Int) {
        guard let model = feeds[safe: index] else { return }
        viewedFeeds.append(model)
        dataBaseManager.setFeed(model: model)
        feeds[index].isView = true
        showFullFeed(model: model)
    }
}

private extension FeedViewModelImpl {
    func updateViewdFeeds() {
        viewedFeeds = dataBaseManager.getFeeds()
    }
}
