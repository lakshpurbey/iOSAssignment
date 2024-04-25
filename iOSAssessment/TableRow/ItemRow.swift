//
//  ItemRow.swift
//  iOSAssessment
//
//  Created by HAR-LAP046-080 on 25/04/2024.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
            if let additionalDetails = item.additionalDetails {
                Text(additionalDetails)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        // Load additional details
                    }
            }
        }
        .padding()
    }
}
