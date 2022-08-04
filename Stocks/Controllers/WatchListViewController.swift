//
//  ViewController.swift
//  Stocks
//
//  Created by Efrain Diaz on 30/07/22.
//

import UIKit

class WatchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchViewController()
    }
    
    private func setupSearchViewController() {
        let resultVC = SearchResultsViewController()
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

// MARK: - UISearchResultsUpdating methods
extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        print(query)
    }
}

