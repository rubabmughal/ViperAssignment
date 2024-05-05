//
//  ModuleAViewModel.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import Foundation

class ModuleAViewModel {
    private var items: [Item] = []

    var itemCount: Int {
        return items.count
    }

    func fetchItems(completion: @escaping (Error?) -> Void) {
        ModuleAAPIDataManager().fetchItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func getItem(at index: Int) -> Item? {
        guard index >= 0, index < items.count else {
            return nil
        }
        return items[index]
    }
}

