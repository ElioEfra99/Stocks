//
//  SearchResultsTableViewCell.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 06/08/22.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    static let identifier = "SearchResultTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
