//
//  CalorieIntakeView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 27.01.2023.
//

import SwiftUI

struct CalorieIntakeView: View {
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    @AppStorage("previousDay") var previousDay = Date()
    @AppStorage("isMale") var isMale : Bool = true
    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("calorieGoal") var calorieGoal : String = ""
    @AppStorage("calorieSpent")var calorieSpent: Int = 0
    @AppStorage("desiredWeight") var desiredWeight: String = ""
    @AppStorage("currentWeight") var currentWeight: String = ""
    @AppStorage("weightDifference") var weightdifference: Int = 0
    @AppStorage("totalCalorieToLose") var totalCalorieToLose : Int = 0
    @AppStorage("initialCalorieToLose") var initialCalorieToLose : Int = 0
    @AppStorage("deficit") var deficit : Double = 0.0
    
    @State private var e_calories: String = ""
    @State private var isEditing = false
    
    func calculateTotalCal(weightdiff: Int) -> Int{
        
        totalCalorieToLose = 7700 * weightdiff
        initialCalorieToLose = 7700 * weightdiff
        
        return totalCalorieToLose
    }
    
    func calculateDays(calIn: Int, calOut: Int) ->Int{
        var totalCal : Double = Double(calculateTotalCal(weightdiff: weightdifference))
        var deficit: Double = Double(calOut - calIn)
        
        var days: Double = (totalCal / deficit)
        
        
       
        
        return Int(days.rounded())
    }
    
    var body: some View {
        
        VStack{
                Spacer()
                
                VStack(alignment: .leading){
                    
                    
                    Text("Calories Burnt Daily").font(.largeTitle).foregroundColor(Color.main3)
                    HStack {
                        Group {
                                  if isEditing {
                                      HStack {
                                          TextField("", text: $e_calories)
                                                          .frame(width: 80, height: 13.5)
                                                          .font(.title2)
                                                          .keyboardType(.numberPad)
                                                          .multilineTextAlignment(.center)
                                                          .padding(10)
                                                          .background(
                                                              RoundedRectangle(cornerRadius: 10)
                                                                  .strokeBorder(Color.white.opacity(0.5), lineWidth: 1)
                                                          )
                                                          .foregroundColor(Color.main3)
                                                          
                                          Button("Save") {
                                              // Handle save button tap here
                                              calorieSpent = Int(e_calories) ?? calorieSpent
                                              isEditing = false
                                          }
                                          .frame(width:50, height:33)
                                          .onTapGesture {
                                              hideKeyboard()
                                          }
                                          .background(RoundedRectangle(cornerRadius: 10).fill(Color.main2)
                                            )
                                              .foregroundColor(Color.main3)
                                      }
                                  }
                            
                            
                            else {
                                      Text("\(calorieSpent)").font(.title).foregroundColor(Color.main3)

                                      Button(action: {
                                          isEditing = true
                                      }) {
                                          Image(systemName: "square.and.pencil")
                                              .fontWeight(.heavy).opacity(0.3)
                                              .foregroundColor(Color.main3)
                                      }
                                  }
                              }
                    }
                    
                    Spacer().frame(height: 50)
                    
                    Text("Your Daily Calorie Intake Goal").font(.subheadline).foregroundColor(Color.main3)
                    ZStack {
                        
                        if calorieGoal.isEmpty{
                            
                            Text("Enter Daily Calories Goal").opacity(0.3)
                        }
                        TextField("Enter Daily Calories Goal", text: $calorieGoal)
                            
                    }.font(.title2)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                    .foregroundColor(Color.main3)
                    
                }
                .padding(.top, 100.0)
                .frame(width: 300)
                Spacer().frame(height: 50)
                
                if(loseWeight){
                    if(Int(calorieGoal) ?? 0 > Int(calorieSpent)){
                        Text("Intake must be lower than calorie spent!").font(.system(size: 20 )).foregroundColor(Color.main3).frame(width:300, height: 50)
                    }else if(Int(calorieGoal) == 0 || Int(calorieGoal) == nil){
                        Text("?? Days").font(.system(size: 80)).foregroundColor(Color.main3)
                        
                    }else{
                        
                        Text("\(calculateDays(calIn: Int(calorieGoal) ?? 0 ,calOut: calorieSpent)) Days").font(.system(size: 50 )).foregroundColor(Color.main3)
                    }
                    
                }else{
                    if(Int(calorieGoal) ?? 0 < Int(calorieSpent)){
                        Text("Intake must be higher than calorie spent!").font(.system(size: 20 )).foregroundColor(Color.main3).frame(width:300, height: 50)
                    }else if(Int(calorieGoal) == 0 || Int(calorieGoal) == nil){
                        Text("?? Days").font(.system(size: 80)).foregroundColor(Color.main3)
                        
                    }else{
                        
                        Text("\(calculateDays(calIn: Int(calorieGoal) ?? 0 ,calOut: calorieSpent)) Days").frame(width:300, height: 50).font(.system(size: 50 )).foregroundColor(Color.main3)
                    }
                    
                }
                
                
                
                Spacer().frame(height: 50)
                
                
                if(loseWeight){
                    NavigationLink(destination: TabViewPage()) {
                        Text("Start Your Journey").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(calorieGoal == "" || (Int(calorieGoal) ?? 0 > Int(calorieSpent))).simultaneousGesture(TapGesture().onEnded{
                        previousDay = .now
                        deficit = (Double(calorieSpent) - (Double(calorieGoal) ?? 0))
                        totalCalorieToLose -= 7700
                        UserDefaults.standard.welcomescreenShown = true
                    })

                    
                    
                }else{
                    NavigationLink(destination: TabViewPage()) {
                        Text("Start Your Journey").frame(width:270).padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(calorieGoal == "" || (Int(calorieGoal) ?? 0 < Int(calorieSpent)))
                        .simultaneousGesture(TapGesture().onEnded{
                            previousDay = .now
                            deficit = (Double(calorieSpent) - (Double(calorieGoal) ?? 0))
                            totalCalorieToLose -= 7700
                            UserDefaults.standard.welcomescreenShown = true
                        })
                   
                }
               
                
            Spacer().frame(height: 200)
            }
        .onTapGesture {
            hideKeyboard()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
            
            .background(Color.main1)
        .onAppear(){
            
            weightdifference = (Int(currentWeight) ?? 0)  - (Int(desiredWeight) ?? 0)
            
            
        }
    }
}

struct CalorieIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieIntakeView()
    }
}
