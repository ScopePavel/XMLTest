//
//  DataBaseManager.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

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
    func setFeed(model: FeedCellViewModel)
    func getFeeds() -> [FeedCellViewModel]
}

final class DataBaseManager: DataBaseManagerProtocol {

    private var realm = try? Realm(configuration: .defaultConfiguration)

    func setFeed(model: FeedCellViewModel) {
        guard
            let realm = realm
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

    func getFeeds() -> [FeedCellViewModel] {
        guard let realm = realm else {
            print("instance realm is nil")
            return []
        }
        let feedsFromDataBase = Array(realm.objects(FeedDataBaseModel.self).map { $0.mapToFeedView() })
        return feedsFromDataBase
    }
}
