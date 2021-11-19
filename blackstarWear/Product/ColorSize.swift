//
//  ColorSize.swift
//  blackstarWear
//
//  Created by Oleksandr Kiianskyi on 05.11.2021.
//

import Foundation

enum Size{
    case S,M,L,XL,XXL
    var description : String {
        switch self {
        case .S: return "S"
        case .M: return "M"
        case .L: return "L"
        case .XL: return "XL"
        case .XXL: return "XXL"
        }
      }
}


class ColorSize{
    let color: String
    let size: [Size]
    init(_ color: String, _ size: [Size]) {
        self.color = color
        self.size = size
    }
}

