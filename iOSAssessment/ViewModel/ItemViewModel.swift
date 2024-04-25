//
//  ItemViewModel.swift
//  iOSAssessment
//
//  Created by HAR-LAP046-080 on 25/04/2024.
//

import Foundation
import SwiftUI

struct Item: Codable, Identifiable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var additionalDetails: String?


}

class ItemViewModel: ObservableObject {
    
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    
    private var currentPage = 1
    private let pageSize = 10

    
    func fetchData() {
        
        guard !isLoading else { return }
        isLoading = true
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode([Item].self, from: data)
                DispatchQueue.main.async {
                    self.items.append(contentsOf: decodedResponse)
                    self.isLoading = false
                    self.currentPage += 1
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()

    }
    
    func computeDetails(for item: Item) {
        // Perform heavy computation here
        // e.g., Fetch additional data for the item from another API endpoint
        DispatchQueue.global().async {
            let computedDetails = "Computed details for \(item.title)"
            DispatchQueue.main.async {
                if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                    self.items[index].additionalDetails = computedDetails
                }
            }
        }
    }
}
