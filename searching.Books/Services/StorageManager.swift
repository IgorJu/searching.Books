//
//  StorageManager.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import Foundation

protocol IStorageManager {
    func saveBooks(_ books: [Item])
    func loadBooks() -> [Item]?
}

final class StorageManager: IStorageManager {
    func saveBooks(_ books: [Item]) {
        UserDefaults.standard.set(encodable: books, forKey: "books")
    }
    
    func loadBooks() -> [Item]? {
        guard let books = UserDefaults.standard.object([Item].self, forKey: "books") else { return []}
        return books
    }
}
