//
//  ViewController.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//
import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "Search book"
        return textField
    }()
    
    private var books: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var searchTask: DispatchWorkItem?
    private let coordinator: SearchCoordinator
    private let query = "book"
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setupSearchTextField()
    }
    
    private func setConstraints() {
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
    
    private func searchBooks(_ query: String) {
        coordinator.viewModel.searchBooks(query) { [weak self] books, error in
            if let books = books {
                self?.books = books
            } else {
                print("Error")
            }
        }
    }
}

//MARK: - TextField delegate
extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        
        searchBooks(text)
        
        return true
    }
}

//MARK: - DataSource, delegate
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
        
        guard let navVC = navigationController else { return }
        let selectedBook = books[indexPath.row]
        coordinator.showBookDetailScreen(for: selectedBook, in: navVC)
    }
}

//MARK: - Настройка параллельного поиска
private extension SearchViewController {
    func setupSearchTextField() {
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        searchTask?.cancel()
        
        let newSearchTask = DispatchWorkItem {
            let query = textField.text ?? ""
        }
        searchTask = newSearchTask
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.searchTask === newSearchTask {
                newSearchTask.perform()
            }
        }
    }
}

