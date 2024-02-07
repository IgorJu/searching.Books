//
//  BookViewModel.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import Foundation

struct BookDetailViewModel {
    let thumbnailURL: URL?
    let title: String
    let authors: String?
    let publishedYear: String
    
    init(book: Item) {
        
        thumbnailURL = URL(string: book.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? "")
        title = book.volumeInfo.title
        authors = book.volumeInfo.authors?.joined(separator: ", ")
        publishedYear = book.volumeInfo.publishedDate ?? ""
    }
}
