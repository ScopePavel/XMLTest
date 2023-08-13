import Foundation

protocol FullFeedViewModel {
    var cellModel: NewsShortDisplayViewModel? { get set }

    func viewControllerIsRemoving()
}

final class FullFeedViewModelImpl: FullFeedViewModel {

    // MARK: - Internal properties

    var cellModel: NewsShortDisplayViewModel?

    // MARK: - Private properties

    private weak var fullFeedOutput: FullFeedOutput?

    // MARK: - Init

    init(fullFeedOutput: FullFeedOutput, model: NewsShortDisplayViewModel) {
        self.cellModel = model
        self.fullFeedOutput = fullFeedOutput
    }

    // MARK: - Public

    func viewControllerIsRemoving() {
        fullFeedOutput?.userDidFinishFlow()
    }
}
