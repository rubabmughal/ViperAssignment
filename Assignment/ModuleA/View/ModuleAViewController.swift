//
//  ViewController.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import UIKit

protocol ModuleAViewProtocol: AnyObject {
    func showItems(_ items: [Item])
    func showError(_ message: String)
}
class ModuleAViewController: UIViewController,ModuleAViewProtocol, UITableViewDelegate {
    
    var presenter: ModuleAPresenterProtocol!
    let APIDataManager = ModuleAAPIDataManager()
    @IBOutlet var tableview: UITableView!
    
    var items: [Item] = []
    private let viewModel = ModuleAViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupTableView()
        fetchItems()
        presenter.viewDidLoad()
       
    }
    
    private func setupPresenter() {
        presenter = ModuleAPresenter()
        presenter.view = self
        presenter.interactor = ModuleAInteractor(APIDataManager: APIDataManager)
        presenter.router = ModuleARouter()
    }
    
    // Implement view methods
    func showItems(_ items: [Item]) {
        // Reload table view with fetched items
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func showError(_ message: String) {
          // Show error message
          DispatchQueue.main.async {
              let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alertController, animated: true, completion: nil)
          }
      }
    
    private func setupTableView() {
     
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(ModuleATableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func fetchItems() {
        viewModel.fetchItems { [weak self] error in
            if let error = error {
                print("Error fetching items:", error)
            } else {
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                    print("count",self?.viewModel.itemCount ?? 0)
                    
                }
            }
        }
    }
}

extension ModuleAViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount//items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ModuleATableViewCell
        
        if let item = viewModel.getItem(at: indexPath.row) {
            print("Item:", item) // Debugging
//            cell.textLabel?.text = item.name
            cell.nameLabel.text = item.name
            cell.countryLabel.text = item.country
//            print("Cell Text:", cell.textLabel?.text) // Debugging
        } else {
            print("Item not found for index:", indexPath.row) // Debugging
        }
        return cell
    }

}

class ModuleATableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let countryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        // Add labels
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)

        // Configure labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false

        // Constraints for nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Constraints for countryLabel
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        // Configure cell appearance
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        countryLabel.font = UIFont.systemFont(ofSize: 14)
        countryLabel.textColor = UIColor.gray
    }

    func configure(with item: Item) {
        // Configure cell with item data
        nameLabel.text = item.name
        countryLabel.text = item.country
    }
}
