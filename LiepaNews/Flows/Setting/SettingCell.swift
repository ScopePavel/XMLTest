import UIKit

final class SettingCell: UITableViewCell, ReusableView {

    // MARK: - Private properties

    private var userDefaultsHelper = UserDefaultsHelper.shared
    private var url: String?

    private lazy var resourceNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var isOnSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.addTarget(
            self,
            action: #selector(switchAction),
            for: .valueChanged
        )
        return switchView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init?(coder:) has not been implemented")
    }

    // MARK: - Public

    func config(url: String) {
        self.url = url
        isOnSwitch.isOn = userDefaultsHelper.getValueFor(key: url)
        resourceNameLabel.text = url
    }
}

// MARK: - Private

private extension SettingCell {

    func setup() {
        backgroundColor = .white
        contentView.bui_addSubviews(
            resourceNameLabel,
            isOnSwitch
        )

        NSLayoutConstraint.activate([
            resourceNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            resourceNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.padding),
            resourceNameLabel.rightAnchor.constraint(equalTo: isOnSwitch.leftAnchor, constant: -Constants.padding),
            resourceNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            isOnSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding),
            isOnSwitch.centerYAnchor.constraint(equalTo: resourceNameLabel.centerYAnchor)
        ])
    }

    @objc func switchAction(_ sender: UISwitch) {
        guard let url = url else { return }
        userDefaultsHelper.setValueFor(key: url, value: sender.isOn)
    }

    enum Constants {
        static let padding: CGFloat = 16
    }
}
