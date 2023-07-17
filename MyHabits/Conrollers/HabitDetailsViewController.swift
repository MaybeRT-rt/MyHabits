//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 25.05.2023.
//

import UIKit
import Toast

final class HabitDetailsViewController: UIViewController, HabitsCollectionViewCellDelegate {
    
    
    func habitCellDidSaveNewHabit() {
        self.view.makeToast("Habit saved or updated successfully!")

        if let habitsViewController = navigationController?.viewControllers.first(where: { $0 is HabitsViewController }) as? HabitsViewController {
            habitsViewController.habitCollection.reloadData()
        }
        tableDate.reloadData()
    }
    

    var habit: Habit?
    private var habitDates: [Date] {
        habit?.trackDates ?? []
    }
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editedHabits))
        button.tintColor = UIColor(named: "Color") ?? UIColor.white
        return button
    }()
    
    private lazy var tableDate: UITableView = {
        var table = UITableView()
        table = UITableView(frame: .zero, style: .grouped)
        table.register(HabitTableViewCell.self, forCellReuseIdentifier: CellReuseID.datas.rawValue)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private enum CellReuseID: String {
        case datas = "DataTableViewCell_ReuseID"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addedSubview()
        setupContrain()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = editButton
        navigationItem.title = habit?.name
    }
    
    private func addedSubview() {
        view.addSubview(tableDate)
    }
    
    @objc func editedHabits() {
        let habitVC = HabitViewController()
        habitVC.delegate = self
        habitVC.actionsDeletage = self
        let habitNavigationViewController = UINavigationController(rootViewController: habitVC)
        
        habitVC.habitName = habit?.name
        habitVC.habitColor = habit?.color
        habitVC.habitDate = habit?.date
        if habit != nil {
            habitVC.habit = habit
            habitVC.isEditingHabit = true
            dismiss(animated: true, completion: nil)
        }
        navigationController?.present(habitNavigationViewController, animated: true, completion: nil)
    }
    
    func setupContrain() {
        NSLayoutConstraint.activate([
            tableDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableDate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func tuneTableView() {

        tableDate.dataSource = self
        tableDate.delegate = self
        tableDate.reloadData()
    }
}

extension HabitDetailsViewController: UITableViewDataSource, UITableViewDelegate  {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.datas.rawValue, for: indexPath) as! HabitTableViewCell
        
        let date = HabitsStore.shared.dates.sorted(by: { $0.compare($1) == .orderedDescending })[indexPath.row]
        if let habit = habit {
            let isTracked = HabitsStore.shared.habit(habit, isTrackedIn: date)
            cell.configure(with: date, isTracked: isTracked, habit: habit)
        }

        return cell
    }
}
