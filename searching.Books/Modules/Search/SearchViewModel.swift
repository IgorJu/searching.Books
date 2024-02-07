//
//  SearchViewModel.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//
import Foundation

final class SearchViewModel {
    
    private let networkManager: INetworkManager
    private let storageManager: IStorageManager
    
    init(networkManager: INetworkManager, storageManager: IStorageManager) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
    func searchBooks(_ query: String, completion: @escaping ([Item]?, Error?) -> Void) {
        networkManager.searchBooks(query) { [weak self] books, error in
            if let books = books {
                self?.storageManager.saveBooks(books)
                completion(books, nil)
            } else {
                if let cachedBooks = self?.storageManager.loadBooks() {
                    completion(cachedBooks, error)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
}

