//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Liz-Mary on 14.05.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var plusButton: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionPlusButton))
        button.tintColor = UIColor(named: "Color") ?? UIColor.white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.navigationBar.backgroundColor = .systemGray6
           navigationItem.rightBarButtonItems = [plusButton]
       }

    @objc func actionPlusButton() {
        let habitViewController = HabitViewController()
        let navigationController = UINavigationController(rootViewController: habitViewController)
        present(navigationController, animated: true, completion: nil)
       }
}

