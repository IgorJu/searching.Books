//
//  ViewController.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//
import UIKit
import Alamofire
import SnapKit

final class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.placeholder = "Search book"
        return tf
    }()
    
    private let query = "book"
    private let viewModel = SearchViewModel(networkManager: NetworkManager(), storageManager: StorageManager())
    
    
    private var books: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var searchTask: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Books"
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "BookCell")
        
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        setConstraints()
        //getSavedSearchResults()
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }
    }
    
    func searchBooks(_ query: String) {
            viewModel.searchBooks(query) { [weak self] books, error in
                if let books = books {
                    self?.books = books
                } else {
                    print("Error")
                }
            }
        }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        
        // Perform search
        searchBooks(text)
        
        return true
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedBook = books[indexPath.row]
        let detailViewController = BookViewController()
        detailViewController.viewModel = BookDetailViewModel(book: selectedBook)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

