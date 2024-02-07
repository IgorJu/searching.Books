//
//  Book.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import Foundation

struct Book: Codable {
    let totalItems: Int
    let items: [Item]
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks?
    let previewLink: String?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
