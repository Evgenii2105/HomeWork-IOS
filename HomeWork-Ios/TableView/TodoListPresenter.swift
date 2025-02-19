//
//  TodoListPresenter.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 19.01.2025.
//

import Foundation
import UIKit

protocol TodoListPresenterProtocol {
    
    var todos: [TodoCellData] { get set }
    
    func addTodo(title: String, subTitle: String)
    func remove(at index: Int)
}

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    
    var todos: [TodoCellData] = []
    
    func addTodo(title: String, subTitle: String) {
        
        let newTodo = TodoCellData(title: title, subTitle: subTitle, isSelected: false)
        todos.append(newTodo)
        view?.addTodo(index: todos.count - 1)
    }
    
    func remove(at index: Int) {
        guard index < todos.count else { return }
        
        todos.remove(at: index)
        view?.remove(index: index)
    }
}

extension TodoListPresenter {
    
    struct Images {
        
        static let circlebadge = UIImage(systemName: "circlebadge")!
        static let circlebadgeFill = UIImage(systemName: "circlebadge.fill")!
        static let trash = UIImage(systemName: "trash")!
    }
}
