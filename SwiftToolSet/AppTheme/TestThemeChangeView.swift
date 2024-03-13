//
//  TestThemeChangeView.swift
//  SwiftToolSet
//
//  Created by cat on 2024/3/13.
//

import SwiftUI

struct TestThemeChangeView: View {
    @State private var changeTheme: Bool = false
    @Environment(\.colorScheme) private var scheme
    @AppStorage("user_theme") private var userTheme: Theme = .systemDefault

    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Button {
                        changeTheme.toggle()
                    } label: {
                        Text("Change Theme")
                    }

                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
}

#Preview {
    TestThemeChangeView()
}
