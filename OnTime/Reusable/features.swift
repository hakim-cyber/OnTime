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



extension View{
    @ViewBuilder func phoneOnlyNavigationView()->some View{
        if UIDevice.current.userInterfaceIdiom == .phone{
            self.navigationViewStyle(.stack)
        }else{
            self
        }
    }
}
import Foundation
import PhotosUI
import SwiftUI


struct ImagePicker:UIViewControllerRepresentable{
    @Binding var image:UIImage?
    class Coordinator:NSObject,PHPickerViewControllerDelegate{
        
        var parent:ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else{return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct ImageWrapper: Codable {
    let data: Data
    
    init(_ image: UIImage) {
        self.data = image.pngData()!
    }
    
    func image() -> UIImage {
        return UIImage(data: data)!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        data = try container.decode(Data.self)
    }
}


import Foundation
import SwiftUI
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
