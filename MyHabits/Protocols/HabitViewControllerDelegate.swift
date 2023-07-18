//
//  HabitViewControllerDelegate.swift
//  MyHabits
//
//  Created by Liz-Mary on 18.07.2023.
//

protocol HabitViewControllerDelegate: AnyObject {
    func habitViewControllerDidUpdateName(_ viewController: HabitViewController, withName name: String?)
}
