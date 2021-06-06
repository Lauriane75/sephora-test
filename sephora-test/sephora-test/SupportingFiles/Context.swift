//
//  Context.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

final class Context {

    let client: HTTPClientType

    init(client: HTTPClientType) {
        self.client = client
    }
}

