//
//  SettingsEditView.swift
//  OnTime
//
//  Created by aplle on 5/8/23.
//

import SwiftUI

struct SettingsEditView: View {
    @Binding var email:String
    @Binding var name :String
    @Binding var image:UIImage?
    
  
    @State var showPicker = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            VStack(alignment: .center){
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100,height: 100)
                    .onTapGesture {
                        showPicker = true
                    }
                    .padding()
                
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    .padding(.horizontal,20)
                    .padding(.vertical,2)
                    .shadow(radius: 30)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    .padding(.horizontal,20)
                    .padding(.vertical,2)
                    .shadow(radius: 30)
                Spacer()
                
              
              
            }
           
          
            .safeAreaInset(edge: VerticalEdge.bottom){
                Button{
                    withAnimation{
                      dismiss()
                    }
                }label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .foregroundColor(colorScheme == .light ? .white:.black)
                        .padding()
                        .background(colorScheme == .light ? .black :.white)
                        .cornerRadius(30)
                        .padding()
                }
            }
            .padding()
            .sheet(isPresented: $showPicker){
                ImagePicker(image: $image)
            }
        }
        
    }
}

