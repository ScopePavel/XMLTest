import Foundation

protocol ParsersConfiguratorProtocol {
    var activeParsers: [ParserProtocol] { get }
    var allParsers: [ParserProtocol] { get }
}

struct ParsersConfiguratorModel {
    let parser: ParserProtocol
    var isOn: Bool

    init(parser: ParserProtocol) {
        self.parser = parser
        self.isOn = UserDefaultsHelper.shared.getValueFor(key: parser.url)
    }
}

final class ParsersConfigurator: ParsersConfiguratorProtocol {

    // MARK: - Internal properties

    var allParsers: [ParserProtocol] {
        models.map({ $0.value.parser }).sorted(by: { $0.url > $1.url })
    }

    var activeParsers: [ParserProtocol] {
        var parsers: [ParserProtocol] = []
        models.forEach { model in
            if model.value.isOn {
                parsers.append(model.value.parser)
            }
        }
        return parsers
    }

    // MARK: - Private properties

    private var models: [String: ParsersConfiguratorModel]

    // MARK: - Init

    init(models: [ParsersConfiguratorModel]) {
        self.models = [:]
        models.forEach { [weak self] parserModel in
            guard let self = self else { return }
            self.models.updateValue(parserModel, forKey: parserModel.parser.url)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(isAddAction),
            name: LLNotifications.parsers,
            object: nil
        )
    }

}

// MARK: - Private

private extension ParsersConfigurator {
    @objc func isAddAction(_ notification: Notification) {
        models.keys.forEach { key in
            if let value = notification.userInfo?[key] as? Bool {
                models[key]?.isOn = value
            }
        }
    }
}
