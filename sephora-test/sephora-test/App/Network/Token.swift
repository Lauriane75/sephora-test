//
//  Token.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

final class Token {

    init() {}

    deinit {
        willDealocate?()
    }

    var willDealocate:(() -> Void)?
}

