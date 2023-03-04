//
//  HistoryView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 9.02.2023.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack{
            Section {
                VStack{
                    Text("Meal 1")
                }
                
                
            } header: {
                Text("Meal History")
            }
            
            Section {
                
            } header: {
                Text("Exercise History")
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
