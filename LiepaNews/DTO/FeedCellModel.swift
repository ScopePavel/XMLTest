protocol FeedCellModel {
    var title: String { get }
    var date: String { get }
    var imageURLString: String? { get }
    var description: String? { get }
    var source: String? { get }
    var isRead: Bool { get }
}

struct FeedNoReadCellModelImpl: FeedCellModel {
    let title: String
    let date: String
    let imageURLString: String?
    let description: String?
    let source: String?
    let isRead = false
}

struct FeedReadCellModelImpl: FeedCellModel {
    let title: String
    let date: String
    let imageURLString: String?
    let description: String?
    let source: String?
    let isRead = true
}
