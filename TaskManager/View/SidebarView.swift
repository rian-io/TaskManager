//
//  SidebarView.swift
//  TaskManager
//
//  Created by Rian de Oliveira on 22/01/24.
//

import SwiftUI

struct SidebarView: View {
    @Binding var userCreatedGroups: [TaskGroup]
    @Binding var selection: TaskSection
    
    var body: some View {
        List(selection: $selection) {
            Section("Favorites") {
                ForEach(TaskSection.allCases) { section in
                    Label(section.displayName, systemImage: section.iconName)
                        .tag(section)
                }
            }
            
            Section("Your Groups") {
                ForEach($userCreatedGroups) { $group in
                    HStack {
                        Image(systemName: "folder")
                        TextField("New Group", text: $group.title)
                    }
                    .tag(TaskSection.list(group))
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            if let index = userCreatedGroups.firstIndex(where: { $0.id == group.id }) {
                                userCreatedGroups.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                let newGroup = TaskGroup(title: "New Group")
                userCreatedGroups.append(newGroup)
            }, label: {
                Label("Add Group", systemImage: "plus.circle")
            })
            .buttonStyle(.borderless)
            .foregroundStyle(Color.accentColor)
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .keyboardShortcut(KeyEquivalent("a"), modifiers: .command)
        }
    }
}

#Preview {
    SidebarView(userCreatedGroups: .constant(TaskGroup.examples()), selection: .constant(TaskSection.all))
        .listStyle(.sidebar)
}
