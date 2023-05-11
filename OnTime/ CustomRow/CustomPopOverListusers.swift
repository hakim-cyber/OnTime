//
//  CustomPopOverListusers.swift
//  OnTime
//
//  Created by aplle on 5/11/23.
//

import SwiftUI

struct CustomPopOverListusers: View {
    var users:[User]
    @Binding var showPopOver:Bool
    var body: some View {
        VStack(alignment: .center){
            ForEach(users,id: \.name) { user in
                HStack(alignment:.center){
                    useImage(text: user.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 40,height: 40)
                    
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing,5)
                    Text(user.email)
                        .fontWeight(.light)
                    
                }
                .padding(.vertical,5)
                .padding(.horizontal,10)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
            }
        }
        .padding()
        .overlay(alignment: .topTrailing){
            Button{
                withAnimation(.spring()) {
                    showPopOver = false
                }
            }label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    
            }
            .padding(5)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
    func useImage(text:String)->Image{
        let data = Data(base64Encoded: text) ?? Data()
        
        let uiImage = UIImage(data: data) ?? UIImage()
        
        return Image(uiImage: uiImage)
    }
}

struct CustomPopOverListusers_Previews: PreviewProvider {
    static var previews: some View {
        let imageData = UIImage(named: "default")?.jpegData(compressionQuality: 0.75)
        let imageText = (imageData?.base64EncodedString())!
        CustomPopOverListusers(users: [User(name: "hakim", email: "aliyev", image: imageText),User(name: "hakim", email: "aliyev", image: imageText),User(name: "hakim", email: "aliyev", image: imageText),User(name: "hakim", email: "aliyev", image: imageText)], showPopOver: .constant(true))
    }
}
