//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 18.05.2023.
//

import UIKit

class HabitViewController: UIViewController, UICollectionViewDelegate {
    
    weak var delegate: HabitsCollectionViewCellDelegate?
    weak var actionsDeletage: HabitDetailsViewController?
    weak var delegateName: HabitViewControllerDelegate?
    
    var habit: Habit?
    
    var habitNumber: Int {
        get {
            let number = UserDefaults.standard.integer(forKey: "habitNumber")
            return max(1, number)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "habitNumber")
        }
    }
    
    var habitName: String?
    var habitColor: UIColor?
    var habitDate: Date?
    var isEditingHabit: Bool = true
    
    private var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "НАЗВАНИЕ"
        
        return label
    }()
    
    private var habitTextField: UITextField = {
        let habitText = UITextField()
        habitText.translatesAutoresizingMaskIntoConstraints = false
        habitText.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        habitText.font = UIFont.systemFont(ofSize: 17)
        
        return habitText
    }()
    
    private var labelColor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "ЦВЕТ"
        
        return label
    }()
    
    private let buttonColor: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
        button.addTarget(self, action: #selector(tappedColorButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let time: UILabel = {
        let times = UILabel()
        times.text = "ВРЕМЯ"
        times.translatesAutoresizingMaskIntoConstraints = false
        times.font = UIFont.boldSystemFont(ofSize: 13)
        
        return times
    }()
    
    private let everyDay: UILabel = {
        let everyDay = UILabel()
        everyDay.text = "Каждый день в "
        everyDay.translatesAutoresizingMaskIntoConstraints = false
        everyDay.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        return everyDay
    }()
    
    private let dateTimeLabel: UILabel = {
        let dateTime = UILabel()
        dateTime.translatesAutoresizingMaskIntoConstraints = false
        dateTime.text = "11:00"
        dateTime.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateTime.textColor = UIColor(named: "Color")
        
        return dateTime
    }()
    
    private let timeDatePicker: UIDatePicker = {
        let dataTimes = UIDatePicker()
        dataTimes.translatesAutoresizingMaskIntoConstraints = false
        dataTimes.datePickerMode = .time
        dataTimes.preferredDatePickerStyle = .wheels
        
        let formatData = DateFormatter()
        formatData.dateFormat =  "HH:mm"
        let data = formatData.date(from: "11:00")
        dataTimes.date = data!
        
        dataTimes.addTarget(self, action: #selector(checkDatePicker(_:)), for: .valueChanged)
        
        return dataTimes
    }()
    
    private let removeButton: UIButton = {
        let remove = UIButton()
        remove.translatesAutoresizingMaskIntoConstraints = false
        remove.setTitle("Удалить привычку", for: .normal)
        remove.setTitleColor(.systemRed, for: .normal)
        remove.addTarget(self, action: #selector(tapRemoveButton), for: .touchUpInside)
        
        return remove
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraint()
        configure()
    }
    
    
    func setupView() {
        if habit == nil {
            self.navigationItem.title = "Coздать"
        } else {
            self.navigationItem.title = "Править"
        }
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        
        view.addSubview(labelName)
        view.addSubview(habitTextField)
        view.addSubview(labelColor)
        view.addSubview(buttonColor)
        view.addSubview(time)
        view.addSubview(everyDay)
        view.addSubview(dateTimeLabel)
        view.addSubview(timeDatePicker)
        view.addSubview(removeButton)
        
    }
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            labelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            habitTextField.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            habitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelColor.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 10),
            labelColor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            buttonColor.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 10),
            buttonColor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonColor.heightAnchor.constraint(equalToConstant: 35),
            buttonColor.widthAnchor.constraint(equalToConstant: 35),
            
            time.topAnchor.constraint(equalTo: buttonColor.bottomAnchor, constant: 10),
            time.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            everyDay.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 10),
            everyDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            dateTimeLabel.topAnchor.constraint(equalTo: everyDay.topAnchor),
            dateTimeLabel.leadingAnchor.constraint(equalTo: everyDay.trailingAnchor),
            
            timeDatePicker.topAnchor.constraint(equalTo: everyDay.bottomAnchor, constant: 10),
            timeDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    func configure() {
        habitTextField.text = habitName
        buttonColor.backgroundColor = habit?.color ?? UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
        timeDatePicker.date = habitDate ?? Date()
        checkDatePicker(timeDatePicker)
        
        removeButton.isHidden = !isEditingHabit || habit == nil
    }
    
    @objc func save() {
        guard let name = habitTextField.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Пустое поле привычки", message: "Введите название своей новой привычки", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "Название привычки"
            }
           
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(cancelAction)
            
            let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak alert] _ in
                guard let textField = alert?.textFields?.first,
                      let text = textField.text else {
                    return
                }
                
                if text.isEmpty {
                    self?.habitTextField.text = "Привычка №\(self?.habitNumber ?? 0)"
                    self?.habitNumber += 1
                } else {
                    self?.habitTextField.text = text
                }
                
                self?.save()
            }
            
            alert.addAction(addAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let selectedColor = buttonColor.backgroundColor ?? .black
        
        if let habit = habit {
            habit.name = name
            habit.color = selectedColor
            habit.date = timeDatePicker.date
            delegateName?.habitViewControllerDidUpdateName(self, withName: name)
        } else {
            let newHabit = Habit(name: name, date: timeDatePicker.date, color: selectedColor)
            HabitsStore.shared.habits.append(newHabit)
        }
        
        HabitsStore.shared.save()
        
        if let habitsViewController = navigationController?.viewControllers.first(where: { $0 is HabitsViewController }) as? HabitsViewController {
            habitsViewController.habitCollection.reloadData()
        }
        
        delegate?.habitCellDidSaveNewHabit()
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedColorButton(_ sender: UIButton) {
        let pickerColor = UIColorPickerViewController()
        self.present(pickerColor, animated: true, completion: nil)
        pickerColor.selectedColor = buttonColor.backgroundColor ?? .black
        pickerColor.delegate = self
    }
    
    @objc func checkDatePicker(_ sender: UIDatePicker) {
        let selectedTime = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedTimeString = dateFormatter.string(from: selectedTime)
        
        DispatchQueue.main.async { [weak self] in // для обновления текста в главной очереди, а не в фоновом потоке
            self?.dateTimeLabel.text = selectedTimeString
        }
    }
    
    @objc func tapRemoveButton() {
        guard let habit = habit else {
            return
        }
        
        let alertController = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \"\(habit.name)\"?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            if let index = HabitsStore.shared.habits.firstIndex(where: { $0 === habit }) {
                HabitsStore.shared.habits.remove(at: index)
            }
            
            if let habitsViewController = self?.navigationController?.viewControllers
                .first(where: { $0 is HabitsViewController }) as? HabitsViewController {
                habitsViewController.habitCollection.reloadData()
                self?.navigationController?.popToViewController(habitsViewController, animated: true)
            } else if let habitDetailsViewController = self?.navigationController?.viewControllers
                .first(where: { $0 is HabitDetailsViewController }) as? HabitDetailsViewController {
            } else {
                self?.dismiss(animated: false) {
                    self?.actionsDeletage?.navigationController?.popToRootViewController(animated: false)
                }
            }
        }
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true)
    }
}
extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        buttonColor.backgroundColor = selectedColor
    }
}
