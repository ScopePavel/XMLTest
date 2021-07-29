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
        titleLabel.text = model.title
    }


    var descriptionNumberOfLines: Int = 3 {
        didSet {
            descriptionLabel.numberOfLines = descriptionNumberOfLines
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionNumberOfLines = 3
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
}
