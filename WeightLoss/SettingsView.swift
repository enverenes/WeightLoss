//
//  SettingsView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 2.02.2023.
//

import SwiftUI

struct RestartView : View {
    
    @Binding var mockCalorie: Int
    @State private var reset: Int? = 0
    @State var mockCalSpent: Int = 0
    @State var isMock: Bool = true
    
    @AppStorage("activityLevel") var selectedItem = "Moderately Active"
    @AppStorage("currentWeight") var currentWeight: String = ""
    @AppStorage("age") var age: String = ""
    @AppStorage("height") var height: String = ""
    @AppStorage("calorieSpent")var calorieSpent: Int = 0
    @AppStorage("calorieGoal") var calorieGoal : String = ""
    @AppStorage("desiredWeight") var desiredWeight: String = ""
    @AppStorage("previousDay") var previousDay = Date()
    @AppStorage("isMale") var isMale : Bool = true
    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("weightDifference") var weightdifference: Int = 0
    @AppStorage("daysPassed") var daysPassed: Int = 0
    @AppStorage("daysLeft") var daysLeft: Int = 0
    @AppStorage("initialDaysLeft") var initialDaysLeft: Int = 0
    @AppStorage("totalCalorieToLose") var totalCalorieToLose : Int = 0
    
    @Binding var showingSheet : Bool
    @State var activityLevel = ["Sedentary", "Lightly Active", "Moderately Active", "Active", "Very Active"]
    
    func calculateCalSpent(age: Int, height: Int, currentWeight: Int, activityLevel: Int, isMale: Bool) -> Int{
        var acMult : Double = 1.0
        
        var basecal: Int
        if(isMale){
            basecal = Int(66.47 + (13.75 * Double(currentWeight)) + (5.003 * Double(height)) - (6.755 * Double(age)))
        }else{
            
            basecal = Int(655.1 + (9.563 * Double(currentWeight)) + (1.850 * Double(height)) - (4.676 * Double(age)))
            
            
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
        
    }
    
    func calculateDays(calSpent: Int, calIntake: Int, weightdiff: Int, isMock: Bool) -> Int{
        let deficit : Int = (calSpent - calIntake)
        
       
        let days : Double = Double(7700 / Double(deficit)) * Double(weightdiff)
        if !isMock{
            totalCalorieToLose = 7700 * weightdiff
            print(days)
            daysLeft = Int(days.rounded())
            initialDaysLeft =  Int(days.rounded())
        }
        
        return Int(days.rounded())
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Button {
                    withAnimation{
                        showingSheet = false
                    }
                } label: {
                    Image(systemName: "xmark").resizable().scaledToFit().frame(width: 25).foregroundColor(Color.main2)
                }.padding(25)
                Spacer()
            }
            Text("Are you sure?").font(.largeTitle).padding().foregroundColor(Color(.systemGray2))
            Text("This action will restart your progress").foregroundColor(Color(.systemGray3))
            
            Spacer()
            HStack{
                
                
            }
            
            Button {
                weightdifference = (Int(currentWeight) ?? 0)  - (Int(desiredWeight) ?? 0)
                calculateDays(calSpent: calorieSpent, calIntake: mockCalorie, weightdiff: (Int(weightdifference) ), isMock: false)
                daysPassed = 0
                
                age = ""
                height = ""
                currentWeight = ""
                selectedItem = "Moderately Active"
                desiredWeight = ""
                calorieGoal = ""
                
                reset = 1
            } label: {
                Text("Restart").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.white).shadow(radius: 2)
            }

            NavigationLink(destination: LossOrGain(), tag: 1, selection: $reset) {
                             
                             }
            /* NavigationLink(destination: LossOrGain().onAppear{
                weightdifference = (Int(currentWeight) ?? 0)  - (Int(desiredWeight) ?? 0)
                calculateDays(calSpent: calorieSpent, calIntake: mockCalorie, weightdiff: (Int(weightdifference) ), isMock: false)
                daysPassed = 0
                
                age = ""
                height = ""
                currentWeight = ""
                selectedItem = "Moderately Active"
                desiredWeight = ""
                calorieGoal = ""
                
            })
             
              {
                Text("Restart the progress").font(.system(size: 20))
                    .padding().background(Color.main2).foregroundColor(Color.main3).cornerRadius(15)
            } */
                Spacer()
            }.onAppear{
                mockCalSpent =  calculateCalSpent(age: Int(age) ?? 0, height: Int(height) ?? 0, currentWeight: Int(currentWeight) ?? 0, activityLevel: activityLevel.firstIndex(of: selectedItem) ?? 1,  isMale: isMale)
            }
            
        }
        
    }

    
    struct SettingsView: View {
        
        @State var mockCalSpent: Int = 0
        @State var currentWeightSt: String = ""
        @State var desiredWeightSt: String = ""
        @State var ageSt: String = ""
        @State var heightSt: String = ""
        @State var activityLevel = ["Sedentary", "Lightly Active", "Moderately Active", "Active", "Very Active"]
        @State var calorieGoalst: Int = 0
        @State var genders = ["Male", "Female"]
        @State var genderSelection = ""
        
        @State var showingSheet = false
        
        @AppStorage("darkMode") var darkMode = false
        @AppStorage("isEuUnits") var isEuUnits: Bool = true

        
        @AppStorage("activityLevel") var selectedItem = "Moderately Active"
        @AppStorage("currentWeight") var currentWeight: String = ""
        @AppStorage("age") var age: String = ""
        @AppStorage("height") var height: String = ""
        @AppStorage("calorieSpent")var calorieSpent: Int = 0
        @AppStorage("calorieGoal") var calorieGoal : String = ""
        @AppStorage("desiredWeight") var desiredWeight: String = ""
        @AppStorage("previousDay") var previousDay = Date()
        @AppStorage("isMale") var isMale : Bool = true
        @AppStorage("loseWeight") var loseWeight: Bool = true
        @AppStorage("weightDifference") var weightdifference: Int = 0
        @AppStorage("daysLeft") var daysLeft: Int = 0
        @AppStorage("initialDaysLeft") var initialDaysLeft: Int = 0
        @AppStorage("totalCalorieToLose") var totalCalorieToLose : Int = 0
        
        func calculateCalSpent(age: Int, height: Int, currentWeight: Int, activityLevel: Int, isMale: Bool) -> Int{
            var acMult : Double = 1.0
            
            var basecal: Int
            if(isMale){
                basecal = Int(66.47 + (13.75 * Double(currentWeight)) + (5.003 * Double(height)) - (6.755 * Double(age)))
            }else{
                basecal = Int(655.1 + (9.563 * Double(currentWeight)) + (1.850 * Double(height)) - (4.676 * Double(age)))
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
            
            
            
          return  Int(Double(basecal) * acMult)
            
            
        }
        
        
        
        var body: some View {
            VStack{
                
                
                Form{
                    Section {
                        HStack{
                            Text("Age: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            Text(ageSt) .multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                        
                        HStack{
                            Text("Height: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            Text((isEuUnits) ? "\(heightSt) cm" : "\(heightSt) feet") .multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                        
                        HStack{
                            Text("Starting Weight: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            Text((isEuUnits) ? "\(currentWeightSt) kgs" : "\(currentWeightSt) lbs") .multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                        HStack{
                            Text("Gender: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            
                            Text((isMale) ? "Male" : "Female").multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                           
                      
                       
                            HStack{
                                Text("Activity Level: ").foregroundColor(Color(.systemGray2))
                                Spacer()
                                
                                Text(selectedItem).multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                                
                            }
                            
                        
                        
                        
                        
                        
                    } header: {
                        Text("Personal Information")
                    }
                    
                    
                    Section {
                        HStack{
                            Text("Weight Goal: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            Text(desiredWeightSt).multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                        HStack{
                            Text("Calorie Spent: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            Text("\(calculateCalSpent(age: Int(ageSt) ?? 0, height: Int(heightSt) ?? 0, currentWeight: Int(currentWeightSt) ?? 0, activityLevel: activityLevel.firstIndex(of: selectedItem) ?? 1,  isMale: isMale))").multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                        }
                        
                        
                        HStack{
                            Text("Calorie Goal (Intake): ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            TextField(value: $calorieGoalst, formatter: NumberFormatter()) {
                                Text("")
                            }.multilineTextAlignment(.trailing).frame(width: 50).foregroundColor(Color(.systemGray2)).disabled(true)
                        }
                        
                        HStack{
                            Text("Calorie Deficit: ").foregroundColor(Color(.systemGray2))
                            Spacer()
                            
                           
                        Text("\((calculateCalSpent(age: Int(ageSt) ?? 0, height: Int(heightSt) ?? 0, currentWeight: Int(currentWeightSt) ?? 0, activityLevel: activityLevel.firstIndex(of: selectedItem) ?? 1,  isMale: isMale) - (Int(calorieGoalst) )))").multilineTextAlignment(.trailing).foregroundColor(Color(.systemGray2))
                                
                            }
                        
                    } header: {
                        Text("Goals")
                    }
                    
                    Section {
                        HStack{
                            Spacer()
                            Button {
                                withAnimation{
                                    showingSheet = true
                                }
                                
                                
                                
                            } label: {
                                Text("Save and Restart")
                            }
                            
                            Spacer()
                        }
                        
                    } header: {
                        
                    }
                    
                    Section {
                        Toggle(isOn: $darkMode) {
                            HStack{
                                Text(darkMode ? "Dark Mode": "Light Mode").foregroundColor(Color(.systemGray2))
                                Image(systemName: "moon.stars.fill").foregroundColor(Color(.systemGray2))
                            }
                           
                        }
                        
                        HStack{
                            Text("Switch Units").foregroundColor(Color(.systemGray2))
                            
                            Spacer()
                            
                           Toggle("EU", isOn: $isEuUnits)
                                        .toggleStyle(.button)
                                        .tint(Color.main2)
                            Toggle("US", isOn: Binding<Bool>(get: {return !self.isEuUnits},
                                                            set: { p in self.isEuUnits = !p}))
                                         .toggleStyle(.button)
                                         .tint(Color.main2)
                        }
                        HStack{
                           
                            NavigationLink {
                                PremiumView()
                            } label: {
                                Text("Upgrade To Premium").foregroundColor(Color(.systemBlue))

                                Image(systemName: "star.circle").foregroundColor(Color(.systemBlue))
                            }
                            
                            
                        }
                    } header: {
                        Text("App Settings")
                    }
                    
                    
                    
                }
                
                
                
                Spacer()
                
                if showingSheet{
                    RestartView(mockCalorie: $calorieGoalst, showingSheet: $showingSheet)
                    
                }
            }
            
            
            .navigationTitle("Settings")
            .onAppear{
                ageSt = age
                heightSt = height
                currentWeightSt = currentWeight
                calorieGoalst = Int(calorieGoal) ?? 0
                desiredWeightSt = desiredWeight
                
                if isMale {
                    genderSelection = "Male"
                }
              
                
                
                
            }
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }

