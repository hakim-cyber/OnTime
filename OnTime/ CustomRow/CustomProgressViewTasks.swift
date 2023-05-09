//
//  CustomProgressViewTasks.swift
//  OnTime
//
//  Created by aplle on 5/9/23.
//

import SwiftUI

struct CustomProgressViewTasks: View {
    var made:Int
    var total:Int
    
    var progress:Double{
        if total != 0{
           return Double(made) / Double(total)
        }else{
            return 0.0
        }
    }
    var body: some View {
        HStack{
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white,lineWidth:1)
                    .frame(width: 20,height: 60)
                    .overlay(alignment: .bottom){
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .frame(width: 20,height: 60 * progress)
                    }
            VStack(alignment: .center){
                Text("\(Int(made))/\(Int(total))")
                    .font(.title3)
                    .bold()
                    .padding(.vertical,2)
              
                Text("tasks")
                    .font(.callout)
                
            }
            .frame(height: 55)
           
                  
            
        }
    }
}

struct CustomProgressViewTasks_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressViewTasks(made: 4, total: 10)
    }
}
