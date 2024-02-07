//
//  NetworkManager.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import Foundation
import Alamofire


protocol INetworkManager {
    func searchBooks(_ query: String, completion: @escaping ([Item]?, Error?) -> Void)
}

final class NetworkManager: INetworkManager {
    
    private var currentSearchRequest: DataRequest?
    
    func searchBooks(_ query: String, completion: @escaping ([Item]?, Error?) -> Void) {
        currentSearchRequest?.cancel()
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        currentSearchRequest = AF.request(url).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let book):
                let items = book.items
                completion(items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

