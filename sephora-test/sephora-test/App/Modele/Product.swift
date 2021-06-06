//
//  Product.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

// MARK: - product

struct Product: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let id: String?
    let description: String?
    let location: String?
    let image: String?
}

// MARK: - ProductItem

struct ProductItem: Equatable {
    let id: String
    let description: String
    let location: String
    let image: String
}
