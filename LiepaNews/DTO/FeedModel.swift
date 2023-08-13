protocol FeedModel {
    var title: String { get }
    var descriptionNews: String? { get }
    var source: String { get }
    var date: String { get }
    var imageURLString: String? { get }

    func isEqual(to destination: FeedModel) -> Bool
}

extension FeedModel where Self: Equatable {
    func isEqual(to newsWithSourceModel: FeedModel) -> Bool {
        return self.title == newsWithSourceModel.title
        && self.descriptionNews == newsWithSourceModel.descriptionNews
        && self.imageURLString == newsWithSourceModel.imageURLString
        && self.date == newsWithSourceModel.date
        && self.source == newsWithSourceModel.source
    }

}

extension FeedModel {
    func mapToFullFeedModel() -> FullFeedModelImpl {
        FullFeedModelImpl(
            title: self.title,
            date: self.date,
            imageURLString: self.imageURLString,
            description: self.descriptionNews,
            source: self.source
        )
    }
}

extension FeedModel {
    func managedObject() -> FeedDataBaseModel {
        let newsForRealm = FeedDataBaseModel()
        newsForRealm.title = title
        newsForRealm.descriptionNews = descriptionNews
        newsForRealm.source = source
        newsForRealm.date = date
        newsForRealm.imageURLString = imageURLString
        return newsForRealm
    }
}

extension FeedModel {

    func mapToFeedNoReadCellModel() -> FeedCellModel {
        FeedNoReadCellModelImpl(
            title: title,
            date: date,
            imageURLString: imageURLString,
            description: descriptionNews,
            source: source
        )
    }

    func mapToFeedReadCellModel() -> FeedCellModel {
        FeedReadCellModelImpl(
            title: title,
            date: date,
            imageURLString: imageURLString,
            description: descriptionNews,
            source: source
        )
    }
}

struct RSSFeedModel: FeedModel, Equatable {
    let title: String
    let descriptionNews: String?
    let source: String
    let date: String
    let imageURLString: String?
}
