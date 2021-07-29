//
//  Utils + Extensions.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import UIKit

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

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerFooterAndHeader<T: UIView>(_: T.Type) where T: ReusableView {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}
