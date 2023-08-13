protocol FullFeedModel {
    var title: String { get }
    var date: String { get }
    var imageURLString: String? { get }
    var description: String? { get }
    var source: String { get }
}

struct FullFeedModelImpl: FullFeedModel {
    let title: String
    let date: String
    let imageURLString: String?
    let description: String?
    let source: String
}
