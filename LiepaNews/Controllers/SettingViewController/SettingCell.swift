import UIKit

final class SettingCell: UITableViewCell, ReusableView {

    // MARK: - Private properties

    private var userDefaultsHelper = UserDefaultsHelper()
    private var parser: ParserProtocol?

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

    func config(parser: ParserProtocol) {
        self.parser = parser
        isOnSwitch.isOn = userDefaultsHelper.getValueFor(key: parser.id)
        resourceNameLabel.text = parser.id
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
            isOnSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding),
            isOnSwitch.centerYAnchor.constraint(equalTo: resourceNameLabel.centerYAnchor)
        ])
    }

    @objc func switchAction(_ sender: UISwitch) {
        guard let parser = parser else { return }
        userDefaultsHelper.setValueFor(key: parser.id, value: sender.isOn)
    }

    enum Constants {
        static let padding: CGFloat = 16
    }
}
