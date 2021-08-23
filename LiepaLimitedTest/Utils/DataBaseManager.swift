//
//  DataBaseManager.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import Foundation
import RealmSwift


class FeedDataBaseModel: Object {
    @Persisted var guId: String
}

protocol DataBaseManagerProtocol {
    func setFeed(model: FeedCellViewModel)
    func getGuids() -> [String]
}

final class DataBaseManager: DataBaseManagerProtocol {
    func setFeed(model: FeedCellViewModel) {
        guard
            let guId =  model.guId,
            let realm = realm
        else { return }
        let feedDataBase = FeedDataBaseModel()
        feedDataBase.guId = guId


        do {
            try realm.write {
                realm.add(feedDataBase)
            }
        } catch {
            print("realm error")
        }
    }

    func getGuids() -> [String] {
        guard let realm = realm else { return [] }
        let guIds = Array(realm.objects(FeedDataBaseModel.self)).map({ $0.guId })
        return guIds
    }

    private var realm = try? Realm()
}
