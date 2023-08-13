import Foundation

protocol FeedViewModel {
    var feeds: [NewsShortDisplayViewModel] { get }
    var onUpdate: (() -> Void)? { get set }

    func start()
    func showSettings()
    func safeFeed(index: Int)
}

final class FeedViewModelImpl: FeedViewModel {

    // MARK: - Internal properties

    var feeds: [NewsShortDisplayViewModel] {
        if newsWithSourceModels.isEmpty { return viewedFeeds.map { $0.convertToReadNewsShortDisplayViewModel() } }
        let newsShortDisplayViewModel = self.newsWithSourceModels.compactMap { model -> NewsShortDisplayViewModel in
            viewedFeeds.contains(where: { $0.isEqual(to: model) })
            ? model.convertToReadNewsShortDisplayViewModel()
            : model.convertToNoReadNewsShortDisplayViewModel()
        }
        return newsShortDisplayViewModel
    }
    var onUpdate: (() -> Void)?

    // MARK: - Private properties

    private var newsWithSourceModels: [NewsWithSourceModel] = []
    private var networkManager: NetworkManager
    private let dataBaseManager: DataBaseManagerProtocol
    private var timer: Timer?
    private var feedOutput: FeedOutput?
    private var viewedFeeds: [NewsWithSourceModel] {
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
        onUpdate?()
        startUpdatesData()
    }

    func showSettings() {
        onUpdate?()
        startUpdatesData()
        feedOutput?.showSettings()
    }

    func showFullFeed(model: NewsShortDisplayViewModel) {
        feedOutput?.showFullFeed(model: model)
    }

    func safeFeed(index: Int) {
        guard let model = newsWithSourceModels[safe: index] else { return }
        dataBaseManager.saveReadNews(model: model.managedObject())
        showFullFeed(model: model.convertToReadNewsShortDisplayViewModel())
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

    func getData() {
        networkManager.getFeeds { [weak self] networkFeeds in
            guard let self = self else { return }
            self.newsWithSourceModels = networkFeeds
            self.onUpdate?()
        }
    }
}
