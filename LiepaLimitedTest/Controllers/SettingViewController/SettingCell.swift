//
//  SettingCell.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 24.08.2021.
//

import UIKit

final class SettingCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var isOnSwitch: UISwitch!
    @IBOutlet private weak var resourceNameLabel: UILabel!
    private var userDefaultsHelper = UserDefaultsHelper()
    private var parser: ParserProtocol?

    func config(parser: ParserProtocol) {
        self.parser = parser
        isOnSwitch.isOn = userDefaultsHelper.getValueFor(key: parser.id)
        resourceNameLabel.text = parser.id
    }

    @IBAction private func switchAction(_ sender: UISwitch) {
        guard let parser = parser else { return }
        userDefaultsHelper.setValueFor(key: parser.id, value: sender.isOn)
    }
}
