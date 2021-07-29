//
//  FeedCell.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import UIKit

struct FeedCellViewModel {
    let title: String
    let autor: String
    let description: String
}

final class FeedCell: UITableViewCell, ReusableView {

    func config(model: FeedCellViewModel) {
        descriptionLabel.text = model.description
    }


    @IBOutlet private weak var descriptionLabel: UILabel!
}
