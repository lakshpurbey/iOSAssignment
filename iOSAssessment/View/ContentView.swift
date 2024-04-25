//
//  ContentView.swift
//  iOSAssessment
//
//  Created by HAR-LAP046-080 on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ItemViewModel()
    
    @State private var showDetail = false
    @State private var selectedItem: Item?

    var body: some View {
        NavigationView {
                   List(viewModel.items) { item in
                       VStack(alignment: .leading) {
                           Text("Title: \(item.title)")
                               .font(.headline)
                           Text("ID: \(item.id)")
                               .font(.subheadline)
                       }
                       .onAppear {
                           if item == viewModel.items.last {
                               viewModel.fetchData()
                           }
                       }
                       .onTapGesture {
                           selectedItem = item
                           showDetail.toggle()
                       }
                   }
                   .navigationTitle("Items")
                   .overlay(viewModel.isLoading ? ProgressView() : nil)
               }
               .sheet(isPresented: $showDetail) {
                   if let item = selectedItem {
                       ItemDetailView(item: item)
                   }
               }
               .onAppear {
                   viewModel.fetchData()
               }
           }
}

#Preview {
    ContentView()
}

