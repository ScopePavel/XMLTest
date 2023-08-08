import Foundation

protocol FullFeedViewModel {
    var cellModel: FeedCellViewModel? { get set }

    func viewControllerIsRemoving()
}

final class FullFeedViewModelImpl: FullFeedViewModel {

    // MARK: - Internal properties

    var cellModel: FeedCellViewModel?

    // MARK: - Private properties

    private weak var fullFeedOutput: FullFeedOutput?

    // MARK: - Init

    init(fullFeedOutput: FullFeedOutput, model: FeedCellViewModel) {
        self.cellModel = model
        self.fullFeedOutput = fullFeedOutput
    }

    // MARK: - Public

    func viewControllerIsRemoving() {
        fullFeedOutput?.userDidFinishFlow()
    }
}
