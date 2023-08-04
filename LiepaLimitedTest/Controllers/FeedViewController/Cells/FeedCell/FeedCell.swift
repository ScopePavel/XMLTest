import UIKit
import SDWebImage

struct FeedCellViewModel {
    let title: String?
    let datePub: String?
    let description: String?
    let url: String?
    let source: String?
    let guId: String?
    var isView = false

    var date: Date {
        datePub?.toDate(format: .rss) ?? Date()
    }
}

extension FeedCellViewModel: Equatable {
    static func == (lhs: FeedCellViewModel, rhs: FeedCellViewModel) -> Bool {
        lhs.guId == rhs.guId
    }
}

extension FeedCellViewModel {
    func mapToDataBase() -> FeedDataBaseModel {
        let dataBaseModel = FeedDataBaseModel()
        dataBaseModel.title = title ?? ""
        dataBaseModel.descriptionNews = description
        dataBaseModel.source = source ?? ""
        dataBaseModel.datePub = datePub ?? ""
        dataBaseModel.imageURLString = url
        return dataBaseModel
    }
}

final class FeedCell: UITableViewCell, ReusableView {

    private let picterImageView: UIImageView = {
       let newsImageView = UIImageView()
        newsImageView.layer.masksToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        return newsImageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 3
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 3
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, sourceLabel, descriptionLabel])
        stackView.spacing = 4.0
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var containerView = UIView()

    var descriptionNumberOfLines: Int = 3 {
        didSet {
            descriptionLabel.numberOfLines = descriptionNumberOfLines
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init?(coder:) has not been implemented")
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
}

private extension FeedCell {
    enum Constants {
        static let padding: CGFloat = 16
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 100
        static let indentImageFromHeader: CGFloat = 16
    }

    func setup() {
        backgroundColor = .white
        containerView.bui_addSubviews(
            stackView,
            picterImageView
        )

        contentView.bui_addSubviews(
            containerView
        )

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.padding
            ),
            contentView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: Constants.padding
            ),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            contentView.bottomAnchor.constraint(
                greaterThanOrEqualTo: containerView.bottomAnchor,
                constant: Constants.padding
            ),
            picterImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            picterImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            picterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            picterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            picterImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: picterImageView.trailingAnchor,
                constant: Constants.indentImageFromHeader
            ),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
}
