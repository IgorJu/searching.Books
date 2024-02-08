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
        view.addSubview(thumbnailImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorsLabel)
        view.addSubview(publishedYearLabel)
        setConstraints()
        setupUI()
    }
        private func setConstraints() {
            thumbnailImageView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.leading.equalTo(view.snp.leading).offset(20)
                make.width.equalTo(100)
                make.height.equalTo(150)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(thumbnailImageView.snp.top)
                make.leading.equalTo(thumbnailImageView.snp.trailing).offset(20)
                make.trailing.equalTo(view.snp.trailing).offset(-20)
            }
            
            authorsLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.leading.equalTo(titleLabel.snp.leading)
                make.trailing.equalTo(titleLabel.snp.trailing)
            }
            
            publishedYearLabel.snp.makeConstraints { make in
                make.top.equalTo(authorsLabel.snp.bottom).offset(10)
                make.leading.equalTo(authorsLabel.snp.leading)
                make.trailing.equalTo(authorsLabel.snp.trailing)
            }
        }
    
    private func setupUI() {
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            authorsLabel.text = viewModel.authors
            publishedYearLabel.text = viewModel.publishedYear
            
            if let thumbnailURL = viewModel.thumbnailURL {
                thumbnailImageView.sd_setImage(with: thumbnailURL, completed: nil)
            }
        }
    }
}
