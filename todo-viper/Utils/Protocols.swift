//
//  Protocols.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import UIKit

protocol PresenterInterface{
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewWillEnterForeground()
    func viewDidLayoutSubviews()
}

extension PresenterInterface {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func viewWillEnterForeground() {}
    func viewDidLayoutSubviews() {}
}

protocol ViewInterface : AnyObject, Storyboarded {
    func prepareUI()
}

protocol RouterInterface {
    var navigationController : UINavigationController? { get }
}
