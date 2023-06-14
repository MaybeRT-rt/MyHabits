//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 18.05.2023.
//

import UIKit

class HabitViewController: UIViewController, UICollectionViewDelegate {
    
    
    weak var delegate: HabitsCollectionViewCellDelegate?
    weak var delegates: HabitsCollectionViewCellDelegate?
    
    var habit: Habit?
    
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
        remove.addTarget(self, action: #selector(tappRemoveButton), for: .touchUpInside)
        
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
        self.navigationItem.title = "Coздать"
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
        timeDatePicker.date = habitDate ?? Date()
        
        removeButton.isHidden = !isEditingHabit || habit == nil
    }
    
    @objc func save() {
        guard let name = habitTextField.text, !name.isEmpty else {
            habitTextField.text = "Привычка"
            return
        }
        
        let selectedColor = buttonColor.backgroundColor ?? .black
        
        if let habit = habit {
            habit.name = name
            habit.color = selectedColor
            habit.date = timeDatePicker.date
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
    
    @objc func tappRemoveButton() {
        
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        buttonColor.backgroundColor = selectedColor
    }
}
