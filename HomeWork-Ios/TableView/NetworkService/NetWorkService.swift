//
//  NetWorkManager.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 11.02.2025.
//

import UIKit

class NetWorkService {
    
    func fetchTodos<T: Decodable>(from urlString: String,
                                  completion: @escaping(Result<T, NetWorkError>) -> Void) {
        guard let urlString = URL(string: "https://dummyjson.com/todos") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlString) { data, _, error in
            if let error = error {
                completion(.failure(.requestFailed(error.localizedDescription)))
                return
            }
            
            guard let jsonData = data else { print("Ошибка: нет данных")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
            
        }
        dataTask.resume()
    }
}
