import UIKit

final class SettingViewController: UIViewController {

    // MARK: - Internal properties

    var viewModel: SettingViewModel?

    // MARK: - Private properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(SettingCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Names.closeButtonTitle, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return button
    }()

    private lazy var timeIntervalTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.placeholder = Constants.Names.textFieldPlaceholder
        textField.addTarget(self, action: #selector(timeIntervalChangedAction), for: .editingChanged)
        return textField
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configView()
    }

}

// MARK: - Private

private extension SettingViewController {
    func setup() {
        view.backgroundColor = .white
        view.bui_addSubviews(
            closeButton,
            timeIntervalTextField,
            tableView
        )

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.editTopInsets
            ),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.padding),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.editButtonHeight),
            closeButton.bottomAnchor.constraint(equalTo: timeIntervalTextField.topAnchor, constant: -Constants.padding),
            timeIntervalTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.padding),
            timeIntervalTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.padding),
            timeIntervalTextField.heightAnchor.constraint(equalToConstant: Constants.timeIntervalTextFieldHeight),
            timeIntervalTextField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -Constants.padding),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func doneAction(_ sender: Any) {
        viewModel?.done()
    }

    @objc func timeIntervalChangedAction(_ sender: UITextField) {
        viewModel?.timeInterval = Double(sender.text ?? "")
    }

    func configView() {
        if let timeInterval = viewModel?.timeInterval {
            timeIntervalTextField.text = "\(timeInterval)"
        }
    }

    enum Constants {
        static let editButtonHeight: CGFloat = 20
        static let editTopInsets: CGFloat = 20
        static let padding: CGFloat = 20
        static let timeIntervalTextFieldHeight: CGFloat = 20

        enum Names {
            static let textFieldPlaceholder = "Time Interval"
            static let closeButtonTitle = "Close"
        }
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.urls.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingCell.reuseIdentifier,
                for: indexPath
            ) as? SettingCell,
            let url = viewModel?.urls[safe: indexPath.row]
        else { return UITableViewCell() }
        cell.config(url: url)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
