//
//  SettingCell.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 24.08.2021.
//

import UIKit

final class SettingCell: UITableViewCell, ReusableView {

    private var userDefaultsHelper = UserDefaultsHelper()
    private var parser: ParserProtocol?

    private lazy var resourceNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(parser: ParserProtocol) {
        self.parser = parser
        isOnSwitch.isOn = userDefaultsHelper.getValueFor(key: parser.id)
        resourceNameLabel.text = parser.id
    }
}

private extension SettingCell {
    func setup() {
        backgroundColor = .white
        contentView.bui_addSubviews(
            resourceNameLabel,
            isOnSwitch
        )

        NSLayoutConstraint.activate([
            resourceNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            resourceNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            resourceNameLabel.rightAnchor.constraint(equalTo: isOnSwitch.leftAnchor, constant: -16),
            isOnSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            isOnSwitch.centerYAnchor.constraint(equalTo: resourceNameLabel.centerYAnchor)
        ])
    }

    @objc func switchAction(_ sender: UISwitch) {
        guard let parser = parser else { return }
        userDefaultsHelper.setValueFor(key: parser.id, value: sender.isOn)
    }
}
