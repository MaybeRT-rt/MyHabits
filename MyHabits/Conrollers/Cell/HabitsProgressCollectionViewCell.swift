//
//  HabitsProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Liz-Mary on 20.05.2023.
//

import UIKit

class HabitsProgressCollectionViewCell: UICollectionViewCell {
    
    var progressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var okLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var progressView: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.progressTintColor = UIColor(named: "Color")
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = .white
           setupSubviews()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
    private func setupSubviews() {
        contentView.addSubview(okLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            
            okLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            okLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            okLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            okLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: 15),
            
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: 15),
            
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

