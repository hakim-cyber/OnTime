//
//  UsersCircleImage .swift
//  OnTime
//
//  Created by aplle on 5/11/23.
//

import SwiftUI

struct UsersCircleImage: View {
    let users:[User]
    var imagesText:[String]{
        var text = [String]()
        for user in users {
            text.append(user.image)
        }
        return text
    }
    var body: some View {
        VStack{
            ZStack{
                
                ForEach(Array(imagesText.indices),id: \.self) { index in
                    if index < 3{
                        useImage(text: imagesText[index])
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 40,height: 40)
                            .offset(x: CGFloat(17 * index))
                    }
                    
                }
                if imagesText.count > 3{
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay(alignment: .center){
                            Text("+\(notUsedCount)")
                        }
                        .frame(width: 40,height: 40)
                        .offset(x: CGFloat(17 * 3.3))
                }
            }
          
        }
        .padding(.vertical,10)
        .padding(.horizontal,60)
    }
    func useImage(text:String)->Image{
        let data = Data(base64Encoded: text) ?? Data()
        
        let uiImage = UIImage(data: data) ?? UIImage()
        
        return Image(uiImage: uiImage)
    }
    var notUsedCount:Int{
        if imagesText.count > 3{
            return imagesText.count - 3
        }else{
            return 0
        }
    }
    
   
}

struct UsersCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        let imageData = UIImage(named: "default")?.jpegData(compressionQuality: 0.75)
        let imageText = imageData?.base64EncodedString()
        UsersCircleImage(users: [User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!),User(name: "", email: "", image: imageText!)])
    }
}
