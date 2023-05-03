//
//  features.swift
//  OnTime
//
//  Created by aplle on 5/2/23.
//

import Foundation
import SwiftUI

extension Color{
    static let backgroundColor = Color(red: 0.329, green: 0.333, blue: 0.663)
    
    
    static func randomColor()->Color{
        Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                  
                )
    }
}
