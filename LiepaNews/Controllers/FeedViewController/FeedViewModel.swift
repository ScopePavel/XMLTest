import Foundation

protocol FeedViewModel {
    var feeds: [FeedCellViewModel] { get set }
    var onUpdate: (() -> Void)? { get set }

    func start()
    func showSettings()
    func setFeed(index: Int)
}

final class FeedViewModelImpl: FeedViewModel {

    // MARK: - Internal properties

    var feeds: [FeedCellViewModel] = []
    var onUpdate: (() -> Void)?

    // MARK: - Private properties

    private var networkManager: NetworkManager
    private let dataBaseManager: DataBaseManagerProtocol
    private var timer: Timer?
    private var feedOutput: FeedOutput?
    private var viewedFeeds: [FeedCellViewModel] {
        dataBaseManager.feeds.sorted(by: { $0.date > $1.date })
    }

    // MARK: - Init

    init(
        parsersConfigurator: ParsersConfiguratorProtocol,
        dataBaseManager: DataBaseManagerProtocol,
        feedOutput: FeedOutput
    ) {
        self.networkManager = NetworkManagerImpl(parsersConfigurator: parsersConfigurator)
        self.dataBaseManager = dataBaseManager
        self.feedOutput = feedOutput
    }

    // MARK: - Public

    func start() {
        getPreloadData()
        startUpdatesData()
    }

    func showSettings() {
        getPreloadData()
        startUpdatesData()
        feedOutput?.showSettings()
    }

    func showFullFeed(model: FeedCellViewModel) {
        feedOutput?.showFullFeed(model: model)
    }

    func setFeed(index: Int) {
        guard let model = feeds[safe: index] else { return }
        dataBaseManager.setFeed(model: model)
        feeds[index].isView = true
        showFullFeed(model: model)
    }
}

// MARK: - Private

private extension FeedViewModelImpl {
    func startUpdatesData() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: UserDefaultsHelper().timeIntervalForTimer,
            repeats: true
        ) {  [weak self] _ in
            self?.getData()
        }

        timer?.fire()
    }

    func getPreloadData() {
        self.feeds = self.viewedFeeds
        onUpdate?()
    }

    func getData() {
        networkManager.getFeeds { [weak self] networkFeeds in
            guard let self = self else { return }
            self.feeds = networkFeeds.compactMap { feed -> FeedCellViewModel? in
                if self.viewedFeeds.contains(feed) {
                    var newFeed = feed
                    newFeed.isView = true
                    return newFeed
                }
                return feed
            }.sorted(by: { $0.date > $1.date })
            self.onUpdate?()
        }
    }
}
