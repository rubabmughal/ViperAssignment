//
//  ModuleARouter.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import UIKit

protocol ModuleARouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class ModuleARouter: ModuleARouterProtocol {
    static func createModule() -> UIViewController {
        let view = ModuleAViewController()
        let presenter: ModuleAPresenterProtocol & ModuleAInteractorOutputProtocol = ModuleAPresenter()
        let interactor: ModuleAInteractorInputProtocol = ModuleAInteractor()
        let router: ModuleARouterProtocol = ModuleARouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}

