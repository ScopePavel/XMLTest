import Foundation

protocol ParsersConfiguratorProtocol {
    func getParsers() -> [ParserProtocol]
    func allParsers() -> [ParserProtocol]
}

struct ParsersConfiguratorModel {
    let parser: ParserProtocol
    var isOn = false

    init(parser: ParserProtocol) {
        self.parser = parser
        self.isOn = UserDefaultsHelper().getValueFor(key: parser.id)
    }
}

final class ParsersConfigurator: ParsersConfiguratorProtocol {

    private var models: [String: ParsersConfiguratorModel]

    func allParsers() -> [ParserProtocol] {
        models.map({ $0.value.parser })
    }

    func getParsers() -> [ParserProtocol] {
        var parsers: [ParserProtocol] = []
        models.forEach { model in
            if model.value.isOn {
                parsers.append(model.value.parser)
            }
        }
        return parsers
    }

    init(models: [ParsersConfiguratorModel]) {
        self.models = [:]
        models.forEach { [weak self] parserModel in
            guard let self = self else { return }
            self.models.updateValue(parserModel, forKey: parserModel.parser.id)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(isAddAction),
            name: LLNotifications.parsers,
            object: nil
        )
    }

    @objc private func isAddAction(_ notification: Notification) {
        models.keys.forEach { key in
            if let value = notification.userInfo?[key] as? Bool {
                models[key]?.isOn = value
            }
        }
    }
}
