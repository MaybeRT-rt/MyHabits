//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 16.05.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    var shouldUseLargeTitles = true
        
    private lazy var infoScrollView: UIScrollView = {
        let scrollInfo = UIScrollView()
        scrollInfo.showsVerticalScrollIndicator = true
        scrollInfo.translatesAutoresizingMaskIntoConstraints = false
        return scrollInfo
    }()
    
    private lazy var infoContentView: UIView = {
        let infoContent = UIView()
        infoContent.translatesAutoresizingMaskIntoConstraints = false
        return infoContent
    }()

    private var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = info.title
        return label
    }()
    
    private var infoLabel: UILabel = {
        let labelInfo = UILabel()
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.numberOfLines = 0
        labelInfo.text = info.info
        
        return labelInfo
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.systemGray5
        
        return separatorView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraint()
        
        updateLargeTitles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        updateLargeTitles()
    }
    
    private func updateLargeTitles() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = shouldUseLargeTitles
        }
    }
    
    func setupView() {
        self.navigationItem.title = "Информация"
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(infoContentView)
        infoContentView.addSubview(separatorView)
        infoContentView.addSubview(labelTitle)
        infoContentView.addSubview(infoLabel)
    }
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            infoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoContentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            infoContentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            infoContentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            infoContentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            infoContentView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor),
            
            separatorView.topAnchor.constraint(equalTo: infoContentView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: infoContentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: infoContentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            labelTitle.topAnchor.constraint(equalTo: infoContentView.topAnchor, constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: infoContentView.leadingAnchor, constant: 20),
            
            infoLabel.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: infoContentView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: infoContentView.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: infoContentView.bottomAnchor)
            
        ])
        
    }
}
