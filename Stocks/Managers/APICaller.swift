//
//  APICaller.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 01/08/22.
//

import Foundation

final public class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static var apiKey: String {
            if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
                return apiKey
            }
            return ""
        }
        
        static var sandboxApiKey: String {
            if let sandboxApiKey = Bundle.main.infoDictionary?["SANDBOX_API_KEY"] as? String {
                return sandboxApiKey
            }
            return ""
        }
        
        static let baseURL = "https://finnhub.io/api/v1/"
    }
    
    private init() { }
    
    
    // MARK: - Public
    
    // get stock info
    
    // search stocks
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        request(
            url: url(for: .search, queryParam: ["q" : query]),
            expecting: SearchResponse.self,
            completion: completion
        )
    }
    
    // MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidURL
        case noDataReturned
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParam: [String: String] = [:]
    ) -> URL? {
        var baseURL = Constants.baseURL + endpoint.rawValue
        
        var queryItems: [URLQueryItem] = []
        
        // Append query parameters
        for (name, value) in queryParam {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Append token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        let queryString = queryItems.map { queryItem in
            "\(queryItem.name)=\(queryItem.value ?? "")"
        }.joined(separator: "&")
        
        baseURL += "?" + queryString
        
        print(baseURL)
        
        return URL(string: baseURL)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
}
