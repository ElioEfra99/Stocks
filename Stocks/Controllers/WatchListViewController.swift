//
//  ViewController.swift
//  Stocks
//
//  Created by Efrain Diaz on 30/07/22.
//

import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: - Properties
    var searchTimer: Timer?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchViewController()
        setupTitleView()
    }
    
    // MARK: - Private methods
    
    private func setupSearchViewController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
    
    private func setupTitleView() {
        let titleView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: navigationController?.navigationBar.height ?? 100)
        )
        
        let label = UILabel(frame: CGRect(x: 10, y: 0,
                                          width: titleView.width - 20,
                                          height: titleView.height))
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "Stocks"
        titleView.addSubview(label)
        
        navigationItem.titleView = titleView
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
        
        // Reset timer
        searchTimer?.invalidate()
        
        // Optimize to reduce number of searches when user stops typing
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            APICaller.shared.search(query: query) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        resultsVC.update(with: success.result)
                    }
                case .failure(_ ):
                    resultsVC.update(with: [])
                }
            }
        }
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        print(searchResult)
    }
}

