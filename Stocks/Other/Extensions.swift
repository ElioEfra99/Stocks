//
//  Extensions.swift
//  Stocks
//
//  Created by Eliu Efraín Díaz Bravo on 03/08/22.
//

import UIKit

// MARK: - UIImageView

extension UIImageView {
    func setImage(from url: URL?) {
        guard let url else {
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
//            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//                guard let data, error == nil else {
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self?.image = UIImage(data: data)
//                }
//            }
//            task.resume()
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    self.image = UIImage(data: data)
                } catch {
                    fatalError()
                }
            }
        }
    }
}

// MARK: - String

extension String {
    static func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.prettyDateFormatter.string(from: date)
    }
}

// MARK: - Date Formatter

extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

// MARK: - Add Subview

extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach {
            addSubview($0)
        }
    }
}

// MARK: - Framing

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var bottom: CGFloat {
        top + height
    }
}

