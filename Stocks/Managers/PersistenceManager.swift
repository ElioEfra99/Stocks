//
//  PersistenceManager.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 01/08/22.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    private let userDefaults: UserDefaults = .standard
    
    struct Constants {
        
    }
    
    private init() {}
    
    // MARK: - Public
    
    public var watchList: [String] {
        return []
    }
    
    public func addToWatchList() {
        
    }
    
    public func removeFromWatchList() {
        
    }
    
    // MARK: - Private
    
    private var hasOnboarded: Bool {
        return false
    }
}
