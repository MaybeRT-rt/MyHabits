//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Liz-Mary on 20.05.2023.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: HabitsCollectionViewCellDelegate?
    
    var habit: Habit? {
            didSet {
                configure()
            }
        }
    
    let habitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTime: UILabel = {
           let time = UILabel()
        time.font = .systemFont(ofSize: 12)
        time.textColor = .systemGray
        time.translatesAutoresizingMaskIntoConstraints = false
           return time
       }()
       
       private lazy var habitCount: UILabel = {
           let count = UILabel()
           count.font = .systemFont(ofSize: 13)
           count.textColor = .systemGray
           count.translatesAutoresizingMaskIntoConstraints = false
           return count
       }()
       

    var circleView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupSubviews()
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped))
        circleView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(habitLabel)
        contentView.addSubview(habitTime)
        contentView.addSubview(habitCount)
        contentView.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitLabel.heightAnchor.constraint(equalToConstant: 20),
            
            habitTime.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 4),
            habitTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitCount.topAnchor.constraint(equalTo: habitTime.bottomAnchor, constant: 30),
            habitCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            circleView.widthAnchor.constraint(equalToConstant: 40),
            circleView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func update(with habit: Habit) {
            self.habit = habit
        }
    
    func updateCircleState() {
        guard let habit = habit else {
            return
        }
        
        if habit.isAlreadyTakenToday == true {
            circleView.backgroundColor = habit.color
            circleView.image = UIImage(systemName: "checkmark")
            circleView.tintColor = .white
        } else {
            circleView.backgroundColor = habit.color
            circleView.image = nil
        }
    }
    
    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.contentView)
        
        if circleView.frame.contains(touchPoint) {
            guard let habit = habit else {
                return
            }
            
            if habit.isAlreadyTakenToday {
                HabitsStore.shared.untrack(habit)
            } else {
                HabitsStore.shared.track(habit)
            }
            
            updateCircleState()
            update(with: habit)
        }
    }
    
    private func configure() {
        guard let habit = habit else {
            return
        }
        
        habitLabel.text = habit.name
        habitLabel.textColor = habit.color
        habitTime.text = habit.dateString
        circleView.layer.borderColor = habit.color.cgColor
        habitCount.text = "Счетчик: \((habit.trackDates.count))"
        
        updateCircleState()
    }
}

