//
//  TabView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 5.02.2023.
//

import SwiftUI

struct TabViewPage: View {
    @State private var selection = 2
    var body: some View {
      TabView(selection: $selection) {
          Text("History").tabItem {
              Image(systemName: "clock.arrow.circlepath")
              Text("History")
          }.tag(1)
            ContentView()
                .tabItem{
                    Image(systemName: "house")
                  Text("Home").font(.system(size: 30))
            }.tag(2)
          SettingsView().tabItem{
              Image(systemName: "slider.horizontal.3")
              Text("Settings").font(.system(size: 30))
          }.tag(3)
            
      }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
