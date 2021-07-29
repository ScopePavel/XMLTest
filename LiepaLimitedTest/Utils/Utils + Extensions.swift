//
//  Utils + Extensions.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
