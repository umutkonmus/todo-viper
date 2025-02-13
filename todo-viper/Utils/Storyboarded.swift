//
//  Storyboarded.swift
//  todo-viper
//
//  Created by Umut Konmuş on 9.02.2025.
//

import UIKit

public protocol Storyboarded {
    static var storyboardName: StoryboardNames { get }
    static func instantiate(identifier: String?) -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate(identifier: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier ?? self.className) as? Self else {
            fatalError("Storyboard cannot instantiated")
        }

        return vc
    }
}

extension NSObject {
    public static var className: String {
        return String(describing: self)
    }
}
