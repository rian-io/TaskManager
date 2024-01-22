//
//  TaskListView.swift
//  TaskManager
//
//  Created by Rian de Oliveira on 22/01/24.
//

import SwiftUI

struct TaskListView: View {
    let title: String
    
    @Binding var tasks: [Task]
    
    @State private var selectedTask: Task? = nil
    @State private var inspectorIsShown: Bool = false
    
    var body: some View {
        List($tasks) { $task in
            TaskView(task: $task, selectedTask: $selectedTask, inspectorIsShown: $inspectorIsShown)
        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    tasks.append(Task(title: "New Task"))
                } label: {
                    Label("Add New Task", systemImage: "plus")
                }
                
                Button {
                    inspectorIsShown.toggle()
                } label: {
                    Label("Show inspector", systemImage: "sidebar.right")
                }
            }
        }
        .inspector(isPresented: $inspectorIsShown) {
            Group {
                if let selectedTask {
                    Text(selectedTask.title).font(.title)
                } else {
                    Text("Nothing selected")
                }
            }
            .frame(minWidth: 100, maxWidth: .infinity)
        }
    }
}

#Preview {
    TaskListView(title: "All", tasks: .constant(Task.examples()))
}
