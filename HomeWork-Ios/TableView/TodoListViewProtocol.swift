//
//  TodoListViewProtocol.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 21.01.2025.
//

import Foundation

protocol TodoListViewProtocol: AnyObject {
    
    func addTodo(index: Int)
    func remove(index: Int)
    func showAlert(title: String, message: String)
}
