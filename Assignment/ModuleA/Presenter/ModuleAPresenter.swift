//
//  ModuleAPresenter.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import Foundation

protocol ModuleAPresenterProtocol: class {
    var view: ModuleAViewProtocol? { get set }
    var interactor: ModuleAInteractorInputProtocol! { get set }
    var router: ModuleARouterProtocol! { get set }

    func viewDidLoad()
}

class ModuleAPresenter: ModuleAPresenterProtocol {
    weak var view: ModuleAViewProtocol?
    var interactor: ModuleAInteractorInputProtocol!
    var router: ModuleARouterProtocol!

    func viewDidLoad() {
        interactor.fetchItems()
    }
    
    // Implement presenter methods
}

extension ModuleAPresenter: ModuleAInteractorOutputProtocol {
    func itemsFetched(_ items: [Item]) {
        view?.showItems(items)
    }

    func itemsFetchFailed(withError error: Error) {
        view?.showError(error.localizedDescription)
    }
}

