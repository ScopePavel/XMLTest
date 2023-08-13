import Foundation

protocol FullFeedViewModel {
    var cellModel: FullFeedModel { get }

    func viewControllerIsRemoving()
}

final class FullFeedViewModelImpl: FullFeedViewModel {

    // MARK: - Internal properties

    let cellModel: FullFeedModel

    // MARK: - Private properties

    private weak var fullFeedOutput: FullFeedOutput?

    // MARK: - Init

    init(fullFeedOutput: FullFeedOutput, model: FullFeedModel) {
        self.cellModel = model
        self.fullFeedOutput = fullFeedOutput
    }

    // MARK: - Public

    func viewControllerIsRemoving() {
        fullFeedOutput?.userDidFinishFlow()
    }
}
