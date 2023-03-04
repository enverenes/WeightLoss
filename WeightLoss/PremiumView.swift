//
//  PremiumView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 12.02.2023.
//

import SwiftUI
import StoreKit

struct PremiumView: View {
    @StateObject var storekit = StoreKitManager()
    
    
    var body: some View {
        VStack{
           
            VStack{
                Spacer().frame(height: 60)
                Text("Buy Premium").font(.system(size: 30))
                Spacer().frame(height: 20)
                Image(systemName: "star.fill").resizable().frame(width: 80,height: 80).scaledToFit()
                Spacer().frame(height: 80)
            }.frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray), Color(.systemGray5)]), startPoint: .topLeading, endPoint: .bottom))
            Divider()
            Spacer()
           
             
            VStack{
                Spacer()
                Text("What You Will Get?").font(.system(size: 22))
                
                Spacer()
                HStack{
                    
                    Image(systemName: "checkmark.circle.fill").padding(.leading, 40)
                    Text("Add custom exercises").font(.system(size: 20))
                    Spacer()
                }
                Spacer().frame(height: 50)
                HStack{
                    
                    Image(systemName: "checkmark.circle.fill").padding(.leading, 40)
                    Text("Add meals and track better").font(.system(size: 20))
                    Spacer()
                }
                Spacer().frame(height: 50)
                HStack{
                    
                    Image(systemName: "checkmark.circle.fill").padding(.leading, 40)
                    Text("Access to home screen widget").font(.system(size: 20))
                    Spacer()
                }

                Spacer()
                
            }
            
            ForEach(storekit.storeProducts) { product in
                HStack{
                    
                    Button {
                        Task{
                            try await storekit.purchase(product)
                            
                        }
                    } label: {
                        Text(product.displayName).padding(.leading)
                        PremiumItem(storeKit: storekit, product: product).padding(.trailing).padding(.vertical, 5)
                    }.background(.black).foregroundColor(.white)
                        .cornerRadius(15)

                   
                }
                Divider()
                           Button("Restore Purchases", action: {
                               Task {
                                   //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                                   //Call this function only in response to an explicit user action, such as tapping a button.
                                   try? await AppStore.sync()
                               }
                           }).padding()
               
            }
            
            
            
        }.navigationTitle("Premium Package")
            
    }
}


struct PremiumItem: View {
    @AppStorage("premium") var isPremium: Bool = false
    @ObservedObject var storeKit : StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {
                Text(product.displayPrice)
                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedProducts) { course in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                isPremium = (try? await storeKit.isPurchased(product)) ?? false

            }
        }
    }
}

struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
    }
}
