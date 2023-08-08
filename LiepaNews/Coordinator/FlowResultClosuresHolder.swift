import Foundation
import UIKit

struct FlowResultClosuresHolder {
    typealias FlowFinishClosure = (CoordinatorFlowResult) -> Void

    enum ClousureType {
        case willFinish
        case didFinish
    }
    let onFlowWillFinish: FlowFinishClosure?
    let onFlowDidFinish: FlowFinishClosure

    init(onFlowWillFinish: FlowFinishClosure? = nil, onFlowDidFinish: @escaping FlowFinishClosure) {
        self.onFlowWillFinish = onFlowWillFinish
        self.onFlowDidFinish = onFlowDidFinish
    }

}

extension FlowResultClosuresHolder {

    static var empty: FlowResultClosuresHolder {
        return FlowResultClosuresHolder { _ in }
    }

    func before(_ closureType: FlowResultClosuresHolder.ClousureType,
                closure: @escaping (() -> Void)) -> FlowResultClosuresHolder {
        switch closureType {
        case .didFinish:
            let onFlowDidFinish = self.onFlowDidFinish
            return FlowResultClosuresHolder(onFlowWillFinish: self.onFlowWillFinish) { result in
                closure()
                onFlowDidFinish(result)
            }
        case .willFinish:
            let onFlowWillFinish = self.onFlowWillFinish
            return FlowResultClosuresHolder(onFlowWillFinish: { result in
                closure()
                onFlowWillFinish?(result)
            }, onFlowDidFinish: self.onFlowDidFinish)
        }
    }
}
