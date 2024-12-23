//
//  ContentView.swift
//  todoList
//
//  Created by kiddo   on 22/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = "";
    @State var todos: [String] = [];
    var body: some View {
        VStack {
            Text("Todo List!")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Add  todo!", text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action : {
                    self.todos.append(self.text);
                    self.text = "";
                }) {
                    Text("Add!")
                        .padding(5)
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color: .black.opacity(0.25), radius: 6)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        List{
            ForEach(self.todos, id: \.self) { todo in
                TodoItem(todo: todo)
                    .onLongPressGesture {
                        if let index = todos.firstIndex(of: todo) {
                            todos.remove(at: index)
                        }
                    }
            }.animation(_: .bouncy)
        }
    }
}

struct Checkbox: View {
    @Binding var checked: Bool
    var body: some View {
        Button(action: {
            self.checked.toggle()
        }) {
            Image(systemName: self.checked ? "checkmark.circle" : "circle")
                .resizable()
                .foregroundColor(.green)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct TodoItem: View {
    @State var todo: String
    @State var checked = false;
    var body: some View {
        HStack {
            Checkbox(checked: $checked)
                .frame(width: 25, height: 25)
            Text(todo)
        }
    }
}

#Preview {
    ContentView()
}
