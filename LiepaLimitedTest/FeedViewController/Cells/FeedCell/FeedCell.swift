//
//  FeedCell.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import UIKit
import SDWebImage

struct FeedCellViewModel {
    let title: String
    let datePub: String
    let description: String
    let url: String
    let source: String
}

final class FeedCell: UITableViewCell, ReusableView {

    func config(model: FeedCellViewModel) {
        descriptionLabel.text = model.description
        titleLabel.text = model.title
        sourceLabel.text = model.source
        picterImageView.sd_setImage(with: URL(string: model.url), completed: nil)
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


    @IBOutlet private weak var picterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
}
