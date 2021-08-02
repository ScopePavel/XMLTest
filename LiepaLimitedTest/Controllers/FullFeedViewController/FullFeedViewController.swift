//
//  FullFeedViewController.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import UIKit

final class FullFeedViewController: UIViewController {
    var viewModel: FullFeedViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        guard let cellModel = viewModel?.cellModel else { return }
        titleLabel.text = cellModel.title ?? ""
        autorLabel.text = cellModel.source ?? ""
        descriptionLabel.text = cellModel.description ?? ""
        if let url = cellModel.url {
            image.sd_setImage(with: URL(string: url), completed: nil)
        }
    }



    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var autorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var image: UIImageView!
}
