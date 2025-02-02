//
//  TodoListPresenter.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 19.01.2025.
//

import Foundation
import UIKit

protocol TodoListPresenterProtocol {
    
    var todos: [TodoItem] { get set }
    
    func addTodo(title: String, subTitle: String)
    func remove(at index: Int)
}

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    
    var todos: [TodoItem] = [
        TodoItem(title: "Test", subTitle: "111", isSelected: false, image: Images.circlebadge),
        TodoItem(title: "Test1", subTitle: "222", isSelected: true, image: Images.circlebadgeFill),
        TodoItem(title: "Test3", subTitle: "333", isSelected: true, image: Images.circlebadge),
        TodoItem(title: "Test4", subTitle: "444", isSelected: true, image: Images.circlebadgeFill)
    ]
    
    func addTodo(title: String, subTitle: String) {
        
        let newTodo = TodoItem(title: title, subTitle: subTitle, isSelected: false, image: Images.circlebadge)
        todos.append(newTodo)
        view?.addTodo(index: todos.count - 1)
    }
    
    func remove(at index: Int) {
        guard index < todos.count else { return }
        
        todos.remove(at: index)
        view?.remove(index: index)
    }
}

private extension TodoListPresenter {
    
    struct Images {
        
        static let circlebadge = UIImage(systemName: "circlebadge")!
        static let circlebadgeFill = UIImage(systemName: "circlebadge.fill")!
        static let trash = UIImage(systemName: "trash")!
    }
}
