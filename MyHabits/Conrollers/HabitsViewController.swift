//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 14.05.2023.
//

import UIKit

class HabitsViewController: UIViewController {
   
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    lazy var habitCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray5
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private enum CellReuseID: String {
        case header = "dayCell"
        case progress = "cellProgress"
        case habits = "cellHabits"
    }
    
    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionPlusButton))
        button.tintColor = UIColor(named: "Color") ?? UIColor.white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        addedSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = "Cегодня"
        navigationItem.rightBarButtonItems = [plusButton]
        habitCollection.reloadData()
    }
    
    private func addedSubviews() {
        view.addSubview(habitCollection)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        habitCollection.register(HabitsProgressCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.progress.rawValue)
        habitCollection.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.habits.rawValue)
        habitCollection.dataSource = self
        habitCollection.delegate = self
    }
    
    @objc private func actionPlusButton() {
        let habitViewController = HabitViewController()
        let navigationController = UINavigationController(rootViewController: habitViewController)
        present(navigationController, animated: true, completion: nil)
        habitViewController.delegate = self
    }
    
    // MARK: - HabitCollectionViewCellDelegate
    
    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: habitCollection)
        guard let indexPath = habitCollection.indexPathForItem(at: touchPoint),
              indexPath.item != 0 else {
            return
        }

        let habit = HabitsStore.shared.habits[indexPath.item - 1] // Поправка на индекс в массиве привычек
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            habitCollection.reloadItems(at: [indexPath])
        }
    }
}

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func habitCellDidTapCircle(_ cell: HabitsCollectionViewCell) {
        guard let indexPath = habitCollection.indexPath(for: cell),
                  indexPath.item != 0 else {
                return
            }
            
            let habit = HabitsStore.shared.habits[indexPath.item - 1] // Поправка на индекс в массиве привычек
            if !habit.isAlreadyTakenToday {
                HabitsStore.shared.track(habit)
                habitCollection.reloadItems(at: [indexPath])
            }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (section == 0) ? 1 : HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if indexPath.section == 0 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseID.progress.rawValue, for: indexPath) as! HabitsProgressCollectionViewCell
             habitsStoreDidChangeTodayProgress()
            cell.layer.cornerRadius = 5
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseID.habits.rawValue, for: indexPath) as! HabitsCollectionViewCell
            
            if indexPath.row < HabitsStore.shared.habits.count {
                let habit = HabitsStore.shared.habits[indexPath.row]
                cell.update(with: habit)
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            return
        }
        
        let habitIndex = indexPath.row
        
        guard habitIndex < HabitsStore.shared.habits.count else {
            return
        }
        let habit = HabitsStore.shared.habits[habitIndex]
        let habitDetailsVC = HabitDetailsViewController()
        habitDetailsVC.habit = habit
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(habitDetailsVC, animated: true)
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    private func widthForSection(collectionViewWidth: CGFloat, numberOfItems: CGFloat, indent: CGFloat) -> CGFloat {
        return (collectionViewWidth - indent * (numberOfItems + 1)) / numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = widthForSection(collectionViewWidth: collectionView.frame.width, numberOfItems: 1, indent: 16)
            let height: CGFloat = 60 // Высота ячейки
            return CGSize(width: width, height: height)
        } else {
            let width = widthForSection(collectionViewWidth: collectionView.frame.width, numberOfItems: 1, indent: 16)
            let height: CGFloat = 120 // Высота ячейки
            
            return CGSize(width: width, height: height)
        }
    }
}

extension HabitsViewController: HabitsCollectionViewCellDelegate {
    
    func habitCellDidSaveNewHabit() {
        habitCollection.reloadData()
    }
}

extension HabitsViewController: HabitsStoreDelegate {
    
    func habitsStoreDidChangeTodayProgress() {
        HabitsStore.shared.delegate = self
        DispatchQueue.main.async {
            let progressIndexPath = IndexPath(item: 0, section: 0)
            if let progressCell = self.habitCollection.cellForItem(at: progressIndexPath) as? HabitsProgressCollectionViewCell {
                let newProgress = HabitsStore.shared.todayProgress
                progressCell.progressLabel.text = "\(Int(newProgress * 100))%"
                progressCell.progressView.setProgress(newProgress, animated: true)
            }
        }
    }
}
