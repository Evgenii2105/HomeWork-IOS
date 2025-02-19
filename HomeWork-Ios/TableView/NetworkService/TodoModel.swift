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
    
    var title: String?
    var isSelected: Bool = false
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isSelected = "completed"
        case title = "todo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.isSelected = try container.decode(Bool.self, forKey: .isSelected)
        self.title = try container.decode(String.self, forKey: .title)
    }
}

extension TodoItem {
    
    func createCell() -> TodoCellData {
        return TodoCellData(
            title: title ?? "Без названияzzz",
            subTitle: "",
            isSelected: isSelected
        )
    }
}
