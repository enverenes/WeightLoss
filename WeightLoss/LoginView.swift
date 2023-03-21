//
//  LoginView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 23.01.2023.
//

import SwiftUI



struct LoginView: View {
    @State var activityLevel = ["Sedentary", "Lightly Active", "Moderately Active", "Active", "Very Active"]
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    @State private var action: Int? = 0

    
    @AppStorage("isMale") var isMale : Bool = true
    @AppStorage("activityLevel") var selectedItem = "Moderately Active"
    @AppStorage("currentWeight") var currentWeight: String = ""
    @AppStorage("age") var age: String = ""
    @AppStorage("height") var height: String = ""
    @AppStorage("calorieSpent") var calorieSpent: Int = 0
    
    @AppStorage("isEuUnits") var isEuUnits: Bool = true
    
    var converter = GlobalClass.shared
    
    func calculateCalSpent(age: Double, height: Double, currentWeight: Double, activityLevel: Int, isMale: Bool) -> Int{
        var acMult : Double = 1.0
        var basecal: Int 
        
        var heightFinal: Double = height
        var currentWeightFinal : Double = currentWeight
        if !isEuUnits{
         heightFinal = converter.convertToCentimetersFromFeet(feet: height)
            currentWeightFinal = converter.convertToKilograms(pounds: currentWeight)
            print(heightFinal,currentWeightFinal)
        }
        
        if(isMale){
             basecal = Int(66.47 + (13.75 * Double(currentWeightFinal)) + (5.003 * Double(heightFinal)) - (6.755 * Double(age)))
        }else{
            
             basecal = Int(655.1 + (9.563 * Double(currentWeightFinal)) + (1.850 * Double(heightFinal)) - (4.676 * Double(age)))
            
           
        }
       
        
        if(activityLevel == 0){
            acMult = 1.2
        }else if(activityLevel == 1){
            acMult = 1.375
        }else if(activityLevel == 2){
            acMult = 1.55
        }else if(activityLevel == 3){
            acMult = 1.725
        }else if(activityLevel == 4){
            acMult = 1.9
        }
       
        return Int(Double(basecal) * acMult)
        // Men kg cm
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                Spacer().frame(height:20)
                VStack(alignment: .leading){
                    Text((isEuUnits) ? "Current Weight (kgs)": "Current Weight (lbs)" ).foregroundColor(Color.main3).multilineTextAlignment(.leading).onTapGesture {
                        hideKeyboard()
                    }
                    ZStack {
                        if currentWeight.isEmpty{
                            
                            Text("Enter Current Weight").opacity(0.3)
                        }
                        TextField("Enter Current Weight", text: $currentWeight).keyboardType(.numberPad)
                    }.multilineTextAlignment(.center)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                        .foregroundColor(Color.main3)
                    
                    
                }
                .frame(width:300)
                .padding(.top, 20.0)
                
                
                
                VStack(alignment: .leading){
                    Text("Age").foregroundColor(Color.main3).multilineTextAlignment(.leading).onTapGesture {
                        hideKeyboard()
                    }
                    ZStack {
                        if age.isEmpty{
                            
                            Text("Enter Age").opacity(0.3)
                        }
                        
                        TextField("Enter Age", text: $age).keyboardType(.numberPad)
                    }.multilineTextAlignment(.center)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                        .foregroundColor(Color.main3)
                }
                .frame(width:300)
                .padding(.top, 20.0)
                
                
                VStack(alignment: .leading){
                    Text((isEuUnits) ? "Height (cm)" : "Height (feet)" )
                        .onTapGesture {
                            hideKeyboard()
                        }
                        .foregroundColor(Color.main3)
                        .multilineTextAlignment(.leading)
                    ZStack {
                        if height.isEmpty{
                            
                            Text("Enter Height").opacity(0.3)
                        }
                        
                        TextField("Enter Height", text:  $height).keyboardType(.numberPad)
                    }.multilineTextAlignment(.center)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                        .foregroundColor(Color.main3)
                    
                }
                .frame(width:300)
                .padding(.top, 20.0)
                
                
                Spacer().frame(width: 50, height: 0)
                HStack {
                    Menu {
                        HStack{
                            Picker(selection:  $selectedItem) {
                                ForEach(activityLevel, id: \.self) { item in // 4
                                    Text(item).font(.largeTitle)// 5
                                }
                            } label: {
                                
                            }
                            
                            Button {
                                
                               
                                
                            } label: {
                                Text("Activity level").fontWeight(.heavy)
                                Image(systemName: "info.circle")
                            }
                            
                            
                        }
                        
                    }label: {
                        Text(selectedItem).foregroundColor(Color.main2)
                            .padding()
                            .frame(width:170)
                        
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .background(Color.main3)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(20)
                    
                    Toggle("EU", isOn: $isEuUnits)
                        .toggleStyle(.button)
                        .tint(Color.main3)
                        
                    Toggle("US", isOn: Binding<Bool>(get: {return !self.isEuUnits},
                                                     set: { p in self.isEuUnits = !p}))
                    .toggleStyle(.button)
                    .tint(Color.main3)
                    
                    Spacer().frame(width:20).onTapGesture {
                        hideKeyboard()
                    }
                }
                
               // Spacer().frame(width: 20, height: 50)
                
              
                Button {
                    hideKeyboard()

                    action = 1
                } label: {
                    Text("Continue").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                }.disabled(  (currentWeight == "" || age == "" ||  height == ""))

                NavigationLink(destination: DesiredGoalView(), tag: 1, selection: $action) {
                                 
                                 }
                
                
            /*    NavigationLink(destination:
                                
                                DesiredGoalView()
                               
                ) {
                    Text("Continue").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                }.disabled(  (currentWeight == "" || age == "" ||  height == ""))*/
            }.offset(y: -self.keyboardHeightHelper.keyboardHeight)
            
            
            
            
        }
        
        .clipped()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.keyboard)
           

            .background(Color.main1)
            .navigationTitle("Information")
            .onAppear {
                
                
                
            }.simultaneousGesture(TapGesture().onEnded{
                calorieSpent = calculateCalSpent(age: Double(age) ?? 1, height:  Double(height) ?? 1, currentWeight:  Double(currentWeight) ?? 1, activityLevel: activityLevel.firstIndex(of: selectedItem) ?? 1, isMale: isMale)
            })
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
