//
//  SearchResultsViewController.swift
//  Stocks
//
//  Created by Efrain Diaz on 30/07/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelect(searchResult: String)
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SearchResultsViewControllerDelegate?
    private var results = [String]()
    
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
    
    public func update(with data: [String]) {
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier,
                                                 for: indexPath)
        if #available(iOS 14.0, *) {
            var content = UIListContentConfiguration.cell()
            content.text = "AAPL"
            content.secondaryText = "Apple Inc."
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = "AAPL"
            cell.detailTextLabel?.text = "Apple Inc."
        }
        
        return cell
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewControllerDidSelect(searchResult: "AAPL")
    }
}
