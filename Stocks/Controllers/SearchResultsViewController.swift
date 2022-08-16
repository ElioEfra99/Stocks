//
//  SearchResultsViewController.swift
//  Stocks
//
//  Created by Efrain Diaz on 30/07/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SearchResultsViewControllerDelegate?
    private var results = [SearchResult]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchResultsTableViewCell.self,
                       forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    // MARK: - Public methods
    
    public func update(with data: [SearchResult]) {
        results = data
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier,
                                                 for: indexPath)
        let result = results[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var content = UIListContentConfiguration.cell()
            content.text = result.displaySymbol
            content.secondaryText = result.description
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = result.displaySymbol
            cell.detailTextLabel?.text = result.description
        }
        
        return cell
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewControllerDidSelect(searchResult: result)
    }
}
