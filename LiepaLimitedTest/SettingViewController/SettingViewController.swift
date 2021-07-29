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
    }

    @IBAction private func doneAction(_ sender: Any) {
        viewModel?.done()
    }

    @IBAction func timeIntervalChangedAction(_ sender: UITextField) {
        viewModel?.timeInterval = Double(sender.text ?? "")
    }
}
