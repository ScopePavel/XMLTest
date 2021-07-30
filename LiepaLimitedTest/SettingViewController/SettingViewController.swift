//
//  SettingViewController.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 30.07.2021.
//

import UIKit

final class SettingViewController: UIViewController {

    var viewModel: SettingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    @IBOutlet private weak var timeIntervalTextField: UITextField!
    @IBOutlet private weak var gazetaSwitch: UISwitch!
    @IBOutlet private weak var lentaSwitch: UISwitch!

    @IBAction private func doneAction(_ sender: Any) {
        viewModel?.done()
    }

    @IBAction private func timeIntervalChangedAction(_ sender: UITextField) {
        viewModel?.timeInterval = Double(sender.text ?? "")
    }

    @IBAction private func gazetaAction(_ sender: UISwitch) {
        viewModel?.isGazeta = sender.isOn
    }

    @IBAction private func lentaAction(_ sender: UISwitch) {
        viewModel?.isLenta = sender.isOn
    }

    private func configView() {
        gazetaSwitch.isOn = viewModel?.isGazeta ?? true
        lentaSwitch.isOn = viewModel?.isLenta ?? true
        if let timeInterval = viewModel?.timeInterval {
            timeIntervalTextField.text = "\(timeInterval)"
        }
    }
}
