//
//  PostDetailView.swift
//  iOSAssessment
//
//  Created by HAR-LAP046-080 on 25/04/2024.
//

import Foundation
import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        VStack {
            Text("Title: \(item.title)")
                .font(.title)
            Text("Body: \(item.body)")
                .padding()
            Spacer()
        }
        .padding()
    }
}
