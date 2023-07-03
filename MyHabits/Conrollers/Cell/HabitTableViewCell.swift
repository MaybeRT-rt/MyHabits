//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Liz-Mary on 03.06.2023.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(checkmarkImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 15),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func configure(with date: Date, isTracked: Bool, habit: Habit) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM y"
        let dateString = formatter.string(from: date)
        dateLabel.text = dateString
        
        let trackedDate = HabitsStore.shared.habit(habit, isTrackedIn: date)
        checkmarkImageView.isHidden = !trackedDate
    }
}

