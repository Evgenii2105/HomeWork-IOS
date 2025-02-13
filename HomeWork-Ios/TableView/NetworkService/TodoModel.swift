//
//  TodoModel.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 11.02.2025.
//

import Foundation
import UIKit

struct TodoModel: Decodable {
 
    var todos: [TodoItem]
}

struct TodoItem: Decodable {
    
    let todos: String?
    let completed: Bool?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case completed
        case todos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(Int.self, forKey: .id)
        self.completed = try? container.decode(Bool.self, forKey: .completed)
        self.todos = try? container.decode(String.self, forKey: .todos)
    }
}

extension TodoItem {
    
    func createCell() -> TodoCellData {
        return TodoCellData(
            title: todos ?? "Без названия",
            subTitle: "",
            isSelected: completed ?? false
        )
    }
}
