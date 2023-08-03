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
        String(describing: self)
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

    func registerCell<Cell: UITableViewCell>(_ cellType: Cell.Type) where Cell: ReusableView {
        register(cellType, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    private func makeReusableIdentifier(for any: AnyClass) -> String {
        NSStringFromClass(any)
    }
}

extension Date {
    func toString(_ format: StringDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

enum StringDateFormat: String {
    case rss = "E, d MMM yyyy HH:mm:ss Z"
}

extension String {
    func toDate(format: StringDateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}

extension UIView {
    @discardableResult
    func bui_addSubviews(
        _ views: UIView...
    ) -> Self {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}
