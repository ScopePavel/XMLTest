import Foundation
import RealmSwift

struct RealmError: Error {
    let description: String
}

class FeedDataBaseModel: Object, NewsWithSourceModel {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionNews: String?
    @objc dynamic var source: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var guId: String?
    @objc dynamic var imageURLString: String?
}

extension FeedDataBaseModel {
    func mapToFeedView() -> FeedCellViewModel {
        FeedCellViewModel(
            title: title,
            datePub: date,
            description: descriptionNews,
            url: imageURLString,
            source: source,
            guId: guId,
            isView: true
        )
    }
}

protocol DataBaseManagerProtocol {
    var feeds: [NewsWithSourceModel] { get }

    func saveReadNews(model: NewsWithSourceModel)
}

final class DataBaseManager: DataBaseManagerProtocol {

    private var realm = try? Realm(configuration: .defaultConfiguration)

    var feeds: [NewsWithSourceModel] {
        guard let realm = realm else { return [] }
        return realm
            .objects(FeedDataBaseModel.self)
            .compactMap { model -> NewsWithSourceModel in model }
    }

    func saveReadNews(model: NewsWithSourceModel) {
        do {
            try self.realm?.write {
                let model = model.managedObject()
                self.realm?.add(model)
            }

        } catch {
            print("write realm error")
        }
    }
}
