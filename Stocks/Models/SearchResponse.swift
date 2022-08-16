//
//  SearchResponse.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 15/08/22.
//

public struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
