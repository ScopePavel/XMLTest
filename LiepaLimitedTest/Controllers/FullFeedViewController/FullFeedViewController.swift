//
//  FullFeedViewController.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import UIKit

final class FullFeedViewController: UIViewController {
    var viewModel: FullFeedViewModel?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configView()
    }

    private func setup() {
        view.backgroundColor = .white
        view.bui_addSubviews(
            titleLabel,
            autorLabel,
            image,
            descriptionLabel
        )

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.Insents.minInsent
            ),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.Insents.minInsent),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.Insents.minInsent),

            titleLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: Constants.Insents.minInsent),
            image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.Insents.minInsent),
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.Insents.minInsent),

            autorLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.Insents.minInsent),
            autorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.Insents.minInsent),
            autorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.Insents.minInsent),
            autorLabel.bottomAnchor.constraint(
                equalTo: descriptionLabel.topAnchor,
                constant: Constants.Insents.minInsent
            ),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.Insents.minInsent),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.Insents.minInsent),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.Insents.minInsent),
            descriptionLabel.bottomAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.Insents.minInsent
            )
        ])
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
}

private extension FullFeedViewController {
    enum Constants {
        enum Insents {
            static let minInsent: CGFloat = 17
        }
    }
}
