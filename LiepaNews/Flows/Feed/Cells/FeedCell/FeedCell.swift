import UIKit
import SDWebImage

final class FeedCell: UITableViewCell, ReusableView {

    // MARK: - Private properties

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

    // MARK: - Init

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
        titleLabel.text = ""
        sourceLabel.text = ""
        descriptionLabel.text = ""
        backgroundColor = .white
        picterImageView.image = nil
    }

    // MARK: - Public

    func config(model: FeedCellModel) {
        descriptionLabel.text = model.description ?? ""
        titleLabel.text = model.title
        sourceLabel.text = model.source ?? ""
        if let url = model.imageURLString {
            picterImageView.sd_setImage(with: URL(string: url), completed: nil)
        }

        backgroundColor = model.isRead ? .green : .white
    }
}

// MARK: - Private

private extension FeedCell {

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

    enum Constants {
        static let padding: CGFloat = 16
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 100
        static let indentImageFromHeader: CGFloat = 16
    }
}
