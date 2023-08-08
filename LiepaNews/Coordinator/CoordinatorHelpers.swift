import Foundation
import UIKit

public enum CoordinatorFlowResult {
    case success
    case userCancelled
    case failure(Error?)
}

public enum CoordinatorPresentationType {
    case push(source: UINavigationController?, initial: UIViewController)
    case present(source: UIViewController?, initial: UIViewController)
    case custom
}
