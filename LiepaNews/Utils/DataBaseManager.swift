import Foundation
import RealmSwift

class FeedDataBaseModel: Object {
    @objc dynamic var title: String?
    @objc dynamic var descriptionNews: String?
    @objc dynamic var source: String?
    @objc dynamic var datePub: String?
    @objc dynamic var guId: String?
    @objc dynamic var imageURLString: String?
}

extension FeedDataBaseModel {
    func mapToFeedView() -> FeedCellViewModel {
        FeedCellViewModel(
            title: title,
            datePub: datePub,
            description: descriptionNews,
            url: imageURLString,
            source: source,
            guId: guId,
            isView: true
        )
    }
}

protocol DataBaseManagerProtocol {
    var feeds: [FeedCellViewModel] { get }

    func setFeed(model: FeedCellViewModel)
}

final class DataBaseManager: DataBaseManagerProtocol {

    private var realm = try? Realm(configuration: .defaultConfiguration)

    func setFeed(model: FeedCellViewModel) {
        guard
            let realm = realm,
            !feeds.contains(model)
        else { return }
        let feedDataBase = model.mapToDataBase()
        do {
            try realm.write {
                realm.add(feedDataBase)
            }
        } catch {
            print("realm error")
        }
    }

    var feeds: [FeedCellViewModel] {
        guard let realm = realm else {
            print("instance realm is nil")
            return []
        }
        let feedsFromDataBase = Array(realm.objects(FeedDataBaseModel.self).map { $0.mapToFeedView() })
        return feedsFromDataBase
    }
}
