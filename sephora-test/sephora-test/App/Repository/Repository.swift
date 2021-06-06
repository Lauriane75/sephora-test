//
//  Repository.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

protocol RepositoryType: AnyObject {
    func getProduct(completion: @escaping(Result<[Product], Error>) -> Void)
}

class Repository: RepositoryType {
    
    private let token = Token()
    private let context: Context
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
    }
    
    func getProduct(completion: @escaping(Result<[Product], Error>) -> Void) {

        let urlString = "https://sephoraios.github.io/items.json"

        guard let url = URL(string: urlString) else { print("invalid URL"); return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("data = \(String(describing: data))")
            print("response = \(String(describing: response))")
            guard error == nil else { print("Error = \(String(describing: error?.localizedDescription))"); return }
            guard data != nil else { return }
            do {
                let result = try JSONDecoder().decode(Product.self, from: data!)
                print("result = \(String(describing: result))")
                completion(.success([result]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

