//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Rian de Oliveira on 22/01/24.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("Task") {
                Button("New Task") {
                    
                }
                .keyboardShortcut(KeyEquivalent("t"), modifiers: .command)
            }
            
            CommandGroup(after: .newItem) {
                Button("New Group") {
                    
                }
            }
        }
        
        Settings {
            Text("Settings")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        MenuBarExtra("plus") {
            Button("Do something amazing") {}
        }
    }
}
