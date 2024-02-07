//
//  SearchCoordinator.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func didSelectBook(_ book: Item)
}

final class SearchCoordinator {
    weak var delegate: SearchCoordinatorDelegate?
    let viewModel: SearchViewModel

    init(networkManager: INetworkManager, storageManager: IStorageManager) {
        self.viewModel = SearchViewModel(networkManager: networkManager, storageManager: storageManager)
    }

    func showSearchScreen(in navigationController: UINavigationController) {
        let searchViewController = SearchViewController(coordinator: self)
        navigationController.pushViewController(searchViewController, animated: true)
    }

    func showBookDetailScreen(for book: Item, in navigationController: UINavigationController) {
        let detailViewController = BookViewController()
        detailViewController.viewModel = BookDetailViewModel(book: book)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
