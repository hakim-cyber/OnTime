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
    
   static func randomForeground()->Color{
         Color(
                     red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
                 )
    }
    static func randomColor()->LinearGradient{
       var randomcolor1 =  Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
                )
        var randomcolor2 =  Color(
                     red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
                 )
       
        return LinearGradient(colors: [randomcolor1,randomcolor2], startPoint: .top, endPoint: .bottom)
    }
}


struct HeartToggleStyle: ToggleStyle {
    var size:Int
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                configuration.isOn.toggle()
            }
           
        }) {
            Image(systemName: configuration.isOn ? "heart.fill" : "heart")
                .foregroundColor(configuration.isOn ? .red : .gray)
                .font(.system(size: CGFloat(size)))
                
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct CheckMarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                configuration.isOn.toggle()
            }
           
        }) {
           
                
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .gray : .gray)
                .font(.system(size: 28))
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}
