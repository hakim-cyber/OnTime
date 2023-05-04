//
//  TasksListRow.swift
//  OnTime
//
//  Created by aplle on 5/4/23.
//

import SwiftUI


struct TasksListRow: View {
    var color:LinearGradient
    @Binding var task:Task
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(color: task.isMade ? .green : .black,radius: task.isMade ? 10 : 0)
                .frame(height: 90)
            HStack{
                Toggle("", isOn: $task.isMade)
                    .toggleStyle(CheckMarkToggleStyle())
                    .labelsHidden()
                VStack(alignment: .leading){
                    
                    Text(task.name)
                        .font(.title3.weight(.bold))
                        .frame(maxWidth:.infinity,alignment: .top)
                        .padding(8)
                        .strikethrough(task.isMade)
                    Text(task.description)
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.gray)
                        .frame(maxWidth:.infinity,alignment: .bottom)
                        .strikethrough(task.isMade)
                    
                }
            }
            .padding()
        }
        .padding(.vertical,10)
        .padding(.horizontal,5)
    }
}

struct TasksListRow_Previews: PreviewProvider {
    static var previews: some View {
        TasksListRow(color: Color.randomColor(), task: .constant(Task(name: "Homework", description: "Make math fizics",isMade: true)))
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
