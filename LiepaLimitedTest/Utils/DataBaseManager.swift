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

final class DataBaseManager {
    func setFeed(model: FeedCellViewModel) {
        guard
            let guId =  model.guId,
            let realm = try? Realm()
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
        do {
            let realm = try Realm()
            let guIds = Array(realm.objects(FeedDataBaseModel.self)).map({ $0.guId })
            return guIds
        } catch {
            print("realm error")
            return []
        }
    }
}
