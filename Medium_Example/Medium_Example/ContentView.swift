//
//  ContentView.swift
//  Medium_Example
//
//  Created by Vishwas NG on 10/10/25.
//

import SwiftUI

enum CurrentState {
    case idle
    case loading
    case loaded
}

struct ContentView: View {
    
    @State var gen: ModelGenerator = ModelGenerator()
    @State private var state: CurrentState = .idle
    @State private var query: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    switch state {
                    case .idle:
                        idleView
                    case .loading:
                        ProgressView {
                            Text("Loading...")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    case .loaded:
                        loadedView
                    }
                }
                .padding()
            }
            .task {
                self.state = .loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    Task {
                        self.state = .loaded
                        try await gen.getResponse(for: "explain UIKit in 1000 words")
                    }
                }
            }
            .navigationTitle("FoundationModel Demo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Reset") {
                withAnimation {
                    self.state = .idle
                }
            })
        }
    }
    
    var idleView: some View {
        VStack(spacing: 20) {
            Text("Make your Query")
                .font(.title2)
                .fontWeight(.semibold)
            
            TextField("Enter a language", text: $query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                withAnimation {
                    self.state = .loading
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    Task {
                        self.state = .loaded
                        try await gen.getResponse(for: query)
                        self.state = .loaded
                    }
                }
            }) {
                Text("Submit")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
        }
        .padding(30)
        .background(Color.white.opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    var loadedView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(gen.response?.name ?? "")
                    .multilineTextAlignment(.center)
                    .font(Font.largeTitle.bold())
                Text(gen.response?.Description ?? "")
                    .animation(.linear)
                Text(gen.response?.url ?? "")
                    .animation(.linear)
                    .foregroundStyle(Color.blue)
            }.padding(20)
            
        }
    }
}
