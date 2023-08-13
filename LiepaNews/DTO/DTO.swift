protocol NewsWithSourceModel {
    var title: String { get }
    var descriptionNews: String? { get }
    var source: String { get }
    var date: String { get }
    var imageURLString: String? { get }

    func isEqual(to destination: NewsWithSourceModel) -> Bool
}

extension NewsWithSourceModel where Self: Equatable {
    func isEqual(to newsWithSourceModel: NewsWithSourceModel) -> Bool {
        return self.title == newsWithSourceModel.title
        && self.descriptionNews == newsWithSourceModel.descriptionNews
        && self.imageURLString == newsWithSourceModel.imageURLString
        && self.date == newsWithSourceModel.date
        && self.source == newsWithSourceModel.source
    }

}

extension NewsWithSourceModel {
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

extension NewsWithSourceModel {

    func convertToNoReadNewsShortDisplayViewModel() -> NewsShortDisplayViewModel {
        NoReadNewsShortDisplayViewModel(
            title: title,
            dateString: date,
            imageURLString: imageURLString,
            description: descriptionNews,
            source: source
        )
    }

    func convertToReadNewsShortDisplayViewModel() -> NewsShortDisplayViewModel {
        ReadNewsShortDisplayViewModel(
            title: title,
            dateString: date,
            imageURLString: imageURLString,
            description: descriptionNews,
            source: source
        )
    }
}

//extension NewsWithSourceModel {
//    func convertToStandartNewsDeployedViewModel() -> StandartNewsDeployedViewModel {
//        StandartNewsDeployedViewModel(title: self.title,
//                                      date: self.date,
//                                      imageURLString: self.imageURLString,
//                                      description: self.descriptionNews,
//                                      source: self.source)
//    }
//}

struct RSSWithSourceModel: NewsWithSourceModel, Equatable {
    let title: String
    let descriptionNews: String?
    let source: String
    let date: String
    let imageURLString: String?
}

/// Описывает новость, на экране списка новостей
protocol NewsShortDisplayViewModel {
    var title: String { get }
    var dateString: String { get }
    var imageURLString: String? { get }
    var description: String? { get }
    var source: String? { get }
    var isRead: Bool { get }
}

/// Структура непрочитанной  новости
struct NoReadNewsShortDisplayViewModel: NewsShortDisplayViewModel {
    let title: String
    let dateString: String
    let imageURLString: String?
    let description: String?
    let source: String?
    let isRead = false
}

/// Структура прочитанной  новости
struct ReadNewsShortDisplayViewModel: NewsShortDisplayViewModel {
    let title: String
    let dateString: String
    let imageURLString: String?
    let description: String?
    let source: String?
    let isRead = true
}
