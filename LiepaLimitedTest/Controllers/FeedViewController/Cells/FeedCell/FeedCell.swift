//
//  FeedCell.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import UIKit
import SDWebImage

struct FeedCellViewModel {
    let title: String?
    let datePub: String?
    let description: String?
    let url: String?
    let source: String?
    let guId: String?

    var isView: Bool = false

    var date: Date {
        datePub?.toDate(format: .rss) ?? Date()
    }
}

final class FeedCell: UITableViewCell, ReusableView {

    var descriptionNumberOfLines: Int = 3 {
        didSet {
            descriptionLabel.numberOfLines = descriptionNumberOfLines
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionNumberOfLines = 3
        backgroundColor = .white
    }

    func config(model: FeedCellViewModel) {
        descriptionLabel.text = model.description ?? ""
        titleLabel.text = model.title ?? ""
        sourceLabel.text = model.source ?? ""
        if let url = model.url {
            picterImageView.sd_setImage(with: URL(string: url), completed: nil)
        }

        backgroundColor = model.isView ? .green : .white
    }

    @IBOutlet private weak var picterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
}
