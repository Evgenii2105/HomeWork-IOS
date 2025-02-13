//
//  NetWorkError.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 11.02.2025.
//

import UIKit

enum NetWorkError: Error {
    case invalidURL
    case requestFailed(String)
    case noData
    case decodingFailed(Error)
}
