import Foundation
import RealmSwift

struct RealmError: Error {
    let description: String
}

class FeedDataBaseModel: Object, FeedModel {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionNews: String?
    @objc dynamic var source: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var guId: String?
    @objc dynamic var imageURLString: String?
}

protocol DataBaseManagerProtocol {
    var feeds: [FeedModel] { get }

    func saveReadNews(model: FeedModel)
}

final class DataBaseManager: DataBaseManagerProtocol {

    private var realm = try? Realm(configuration: .defaultConfiguration)

    var feeds: [FeedModel] {
        guard let realm = realm else { return [] }
        return realm
            .objects(FeedDataBaseModel.self)
            .compactMap { model -> FeedModel in model }
    }

    func saveReadNews(model: FeedModel) {
        do {
            if !feeds.contains(where: { $0.isEqual(to: model.managedObject()) }) {
                try self.realm?.write {
                    let model = model.managedObject()
                    self.realm?.add(model)
                }
            }
        } catch {
            print("write realm error")
        }
    }
}
