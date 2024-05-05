//
//  ModuleAInteractor.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import Foundation

import Foundation

protocol ModuleAInteractorInputProtocol: AnyObject {
    var presenter: ModuleAInteractorOutputProtocol! { get set }
//    var localDataManager: ModuleALocalDataManagerInputProtocol! { get set }
    
    func fetchItems()
}

protocol ModuleAInteractorOutputProtocol: AnyObject {
    func itemsFetched(_ items: [Item])
    func itemsFetchFailed(withError error: Error)
}

class ModuleAInteractor: ModuleAInteractorInputProtocol {
    weak var presenter: ModuleAInteractorOutputProtocol!
    var APIDataManager: ModuleAAPIDataManagerInputProtocol!
//    var localDataManager: ModuleALocalDataManagerInputProtocol!

    func fetchItems() {
        // First, try fetching items from local data manager
//        if let cachedItems = localDataManager.fetchCachedItems() {
//            presenter.itemsFetched(cachedItems)
//        } else {
            // If not available locally, fetch from API
            APIDataManager.fetchItems { [weak self] result in
                switch result {
                case .success(let items):
                    // Cache items locally
//                    self?.localDataManager.cacheItems(items)
                    self?.presenter.itemsFetched(items)
                case .failure(let error):
                    self?.presenter.itemsFetchFailed(withError: error)
                }
            }
//        }
    }
}

