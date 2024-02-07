//
//  DetailViewController.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import UIKit
import SDWebImage

final class BookViewController: UIViewController {
    
    var viewModel: BookDetailViewModel?
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let publishedYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Добавление элементов интерфейса на вьюконтроллер
        view.addSubview(thumbnailImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorsLabel)
        view.addSubview(publishedYearLabel)
        
        // Настройка расположения элементов интерфейса
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 100),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            authorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            publishedYearLabel.topAnchor.constraint(equalTo: authorsLabel.bottomAnchor, constant: 10),
            publishedYearLabel.leadingAnchor.constraint(equalTo: authorsLabel.leadingAnchor),
            publishedYearLabel.trailingAnchor.constraint(equalTo: authorsLabel.trailingAnchor)
        ])
        
        // Загрузка данных из вью-модели и отображение на интерфейсе
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            authorsLabel.text = viewModel.authors
            publishedYearLabel.text = viewModel.publishedYear
            
            if let thumbnailURL = viewModel.thumbnailURL {
                // Загрузка изображения из URL с использованием SDWebImage
                thumbnailImageView.sd_setImage(with: thumbnailURL, completed: nil)
            }
        }
    }
}
