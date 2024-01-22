//
//  ContentView.swift
//  TaskManager
//
//  Created by Rian de Oliveira on 22/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = TaskSection.all
    
    @State private var allTasks = Task.examples()
    @State private var userCreatedGroups: [TaskGroup] = TaskGroup.examples()
    
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationSplitView {
            SidebarView(userCreatedGroups: $userCreatedGroups, selection: $selection)
        } detail: {
            if searchTerm.isEmpty {
                switch selection {
                case .all:
                    TaskListView(title: TaskSection.all.displayName, tasks: $allTasks)
                case .done:
                    StaticTaskListView(title: TaskSection.done.displayName, tasks: allTasks.filter({ $0.isCompleted }))
                case .upcoming:
                    StaticTaskListView(title: TaskSection.upcoming.displayName, tasks: allTasks.filter({ !$0.isCompleted }))
                case .list(let taskGroup):
                    StaticTaskListView(title: taskGroup.title, tasks: taskGroup.tasks)
                }
            } else {
                StaticTaskListView(title: "All", tasks: allTasks.filter({$0.title.contains(searchTerm)}))
            }
            
        }
        .searchable(text: $searchTerm)
    }
}

#Preview {
    ContentView()
}
