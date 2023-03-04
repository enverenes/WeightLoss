//
//  DesiredGoalView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 27.01.2023.
//

import SwiftUI

struct DesiredGoalView: View {
   
    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("desiredWeight") var desiredWeight: String = ""
    @AppStorage("currentWeight") var currentWeight: String = ""

    var body: some View {
        
        
            VStack{
                
                
                Text(currentWeight)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .frame(width: 300).foregroundColor(Color.main3)
                
                Image(systemName: "arrow.down").resizable().padding().frame( width: 80,height: 100).scaledToFit().foregroundColor(Color.main3)
                TextField("Enter Desired Weight (kgs)", text: $desiredWeight).keyboardType(.numberPad).multilineTextAlignment(.center)
                    .font(.title2)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                    .frame(width: 200).foregroundColor(Color.main3)
                
                Spacer().frame(height: 50)
                if(((Int(desiredWeight) ?? 0 >= Int(currentWeight) ?? 0)) && loseWeight){
                    Text("Please enter a lower number").foregroundColor(Color.main3)
                    
                }else if(((Int(desiredWeight) ?? 0 <= Int(currentWeight) ?? 0)) && !(loseWeight)){
                    Text("Please enter a higher number").foregroundColor(Color.main3)
                    
                }
                Spacer().frame(height: 50)
                
                
                if(loseWeight){
                    NavigationLink(destination: CalorieIntakeView()) {
                        Text("Continue").padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 >= Int(currentWeight) ?? 0))
                    
                }else{
                    NavigationLink(destination: CalorieIntakeView()) {
                        Text("Continue").padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 <= Int(currentWeight) ?? 0))
                    
                }
                
            
        
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.main1).onAppear{
                print(loseWeight)
            }
       
       
    }
}

struct DesiredGoalView_Previews: PreviewProvider {
    static var previews: some View {
        DesiredGoalView()
    }
}
