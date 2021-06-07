//
//  Context.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

final class Context {
    
    let client: HTTPClientType
    let stack: CoreDataStack
    
    init(client: HTTPClientType, stack: CoreDataStack) {
        self.client = client
        self.stack = stack
    }
}

