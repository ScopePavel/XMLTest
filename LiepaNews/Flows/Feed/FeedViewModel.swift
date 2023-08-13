import Foundation

protocol FeedViewModel {
    var feeds: [FeedCellModel] { get }
    var onUpdate: (() -> Void)? { get set }

    func start()
    func showSettings()
    func safeFeed(index: Int)
}

final class FeedViewModelImpl: FeedViewModel {

    // MARK: - Internal properties

    var feeds: [FeedCellModel] {
        if newsWithSourceModels.isEmpty { return viewedFeeds.map { $0.mapToFeedReadCellModel() } }
        let newsShortDisplayViewModel = self.newsWithSourceModels.compactMap { model -> FeedCellModel in
            viewedFeeds.contains(where: { $0.isEqual(to: model) })
            ? model.mapToFeedReadCellModel()
            : model.mapToFeedNoReadCellModel()
        }.sorted(by: { feed1, feed2 -> Bool in
            guard
                let date1 = feed1.date.toDate(format: .rss),
                let date2 = feed2.date.toDate(format: .rss)
            else { return false }
            return date1.compare(date2) == .orderedDescending
        })
        return newsShortDisplayViewModel
    }
    var onUpdate: (() -> Void)?

    // MARK: - Private properties

    private var newsWithSourceModels: [FeedModel] = []
    private var networkManager: NetworkManager
    private let dataBaseManager: DataBaseManagerProtocol
    private var timer: Timer?
    private var feedOutput: FeedOutput?
    private var viewedFeeds: [FeedModel] {
        dataBaseManager.feeds.sorted(by: { feed1, feed2 -> Bool in
            guard
                let date1 = feed1.date.toDate(format: .rss),
                let date2 = feed2.date.toDate(format: .rss)
            else { return false }
            return date1.compare(date2) == .orderedDescending
        })
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
        onUpdate?()
        startUpdatesData()
    }

    func showSettings() {
        onUpdate?()
        startUpdatesData()
        feedOutput?.showSettings()
    }

    func showFullFeed(model: FullFeedModel) {
        feedOutput?.showFullFeed(model: model)
    }

    func safeFeed(index: Int) {
        guard let model = newsWithSourceModels[safe: index] else { return }
        dataBaseManager.saveReadNews(model: model.managedObject())
        showFullFeed(model: model.mapToFullFeedModel())
    }
}

// MARK: - Private

private extension FeedViewModelImpl {
    func startUpdatesData() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: UserDefaultsHelper.shared.timeIntervalForTimer,
            repeats: true
        ) {  [weak self] _ in
            self?.getData()
        }

        timer?.fire()
    }

    func getData() {
        networkManager.getFeeds { [weak self] networkFeeds in
            guard let self = self else { return }
            self.newsWithSourceModels = networkFeeds
            self.onUpdate?()
        }
    }
}
