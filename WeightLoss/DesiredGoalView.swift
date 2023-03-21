//
//  DesiredGoalView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 27.01.2023.
//

import SwiftUI

struct DesiredGoalView: View {
    @State private var action: Int? = 0
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("desiredWeight") var desiredWeight: String = ""
    @AppStorage("currentWeight") var currentWeight: String = ""
    @AppStorage("isEuUnits") var isEuUnits: Bool = true
    @State var angle: Double = 0
    @State var move: Bool = true

    var body: some View {
        
        
            VStack{
                
                HStack {
                    Spacer()
                    Text(currentWeight)
                        .font(.system(size: 90))
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    //.frame(width: 400, height: 40)
                    .foregroundColor(Color.main3)
                    
                    VStack {
                        Spacer().frame(height:15)
                        Text((isEuUnits) ? ("kgs") : ("lbs"))
                            .font(.system(size: 40))
                            .fontWeight(.ultraLight)
                            .multilineTextAlignment(.center)
                        //.frame(width: 400, height: 40)
                        .foregroundColor(Color.main3)
                    }
                    Spacer()
                }
               // Spacer().frame(height: 10)
                
                Image(systemName: "arrow.down")
                    .resizable()
                    .padding()
                    .frame( width: 75,height:90)
                    .scaledToFit()
                    .foregroundColor(Color.main3)
                    .rotationEffect(.degrees(angle))

                  
                
                   /* .offset(y: move ? 0 : 10)
                    .animation(Animation.easeOut(duration: 1.5)             .repeatForever(autoreverses: true))
                                                    .onAppear {
                                                        self.move.toggle()
                                                    }*/

                   // .onAppear()
                
             //   Spacer().frame(height:0)

                
                
                if(((Int(desiredWeight) ?? 0 >= Int(currentWeight) ?? 0)) && loseWeight){
                    Text("Please enter a lower number").foregroundColor(Color.main3)
                    
                }else if(((Int(desiredWeight) ?? 0 <= Int(currentWeight) ?? 0)) && !(loseWeight)){
                    Text("Please enter a higher number").foregroundColor(Color.main3)
                    
                } else{
                    Text(" ").foregroundColor(Color.main3)

                    
                }
                Spacer().frame(height: 20)
                ZStack {
                    if desiredWeight.isEmpty{
                        
                        Text((isEuUnits) ? ("Enter Desired Weight (kgs)") : ("Enter Desired Weight (lbs)")).opacity(0.3)
                    }
                    
                    TextField((isEuUnits) ? ("Enter Desired Weight (kgs)") : ("Enter Desired Weight (lbs)"), text: $desiredWeight).keyboardType(.numberPad)
                }.multilineTextAlignment(.center)
                    .font(.title2)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                .frame(width: 300).foregroundColor(Color.main3)
                
                if(loseWeight){
                    
                    Button {
                        hideKeyboard()

                        action = 1
                    } label: {
                        Text("Continue").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 >= Int(currentWeight) ?? 0))

                    NavigationLink(destination: CalorieIntakeView(), tag: 1, selection: $action) {
                                     
                                     }
                    
                    
                    
                    
                    /*NavigationLink(destination: CalorieIntakeView()) {
                        Text("Continue").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 >= Int(currentWeight) ?? 0))*/
                    
                }else{
                    
                    Button {
                        hideKeyboard()

                        action = 1
                    } label: {
                        Text("Continue").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 <= Int(currentWeight) ?? 0))

                    NavigationLink(destination: CalorieIntakeView(), tag: 1, selection: $action) {
                                     
                                     }
                    
                    
                    /*NavigationLink(destination: CalorieIntakeView()) {
                        Text("Continue")
                            .frame(width:270)                            .padding(15)
                            .background(Color.main2)
                            .cornerRadius(15)
                            .foregroundColor(Color.main3)
                            .shadow(radius: 2)
                    }.disabled(desiredWeight == "" || (Int(desiredWeight) ?? 0 <= Int(currentWeight) ?? 0)) */
                    
                }
                
                Spacer().frame(height:50)
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
            .background(Color.main1).onAppear{
                print(loseWeight)
            }
            .navigationTitle("Goal")
            .onTapGesture {
                hideKeyboard()
            }
       
       
    }
}

struct DesiredGoalView_Previews: PreviewProvider {
    static var previews: some View {
        DesiredGoalView()
    }
}

