//
//  CalorieIntakeView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 27.01.2023.
//

import SwiftUI

struct CalorieIntakeView: View {
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
                HStack{
                    Text("Calorie Spent Daily: \(calorieSpent)").font(.title).foregroundColor(Color.main3)
                    Image(systemName: "flame").foregroundColor(Color.red)
                }
                
                
                VStack(alignment: .leading){
                    
                    Text("Your Daily Calorie Intake Goal").foregroundColor(Color.main3)
                    TextField("Enter Daily Calorie Goal", text: $calorieGoal).keyboardType(.numberPad).multilineTextAlignment(.center)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                        .frame(width: 300).foregroundColor(Color.main3)
                    
                }
                .padding(.top, 100.0)
                
                
                Spacer().frame(height: 100)
                
                if(loseWeight){
                    if(Int(calorieGoal) ?? 0 > Int(calorieSpent)){
                        Text("!! Intake must be lower than calorie spent !!").font(.system(size: 20 )).foregroundColor(Color.main3)
                    }else if(Int(calorieGoal) == 0 || Int(calorieGoal) == nil){
                        Text("?? Days").font(.system(size: 80)).foregroundColor(Color.main3)
                        
                    }else{
                        
                        Text("\(calculateDays(calIn: Int(calorieGoal) ?? 0 ,calOut: calorieSpent)) Days").font(.system(size: 80 )).foregroundColor(Color.main3)
                    }
                    
                }else{
                    if(Int(calorieGoal) ?? 0 < Int(calorieSpent)){
                        Text("!! Intake must be higher than calorie spent !!").font(.system(size: 20 )).foregroundColor(Color.main3)
                    }else if(Int(calorieGoal) == 0 || Int(calorieGoal) == nil){
                        Text("?? Days").font(.system(size: 80)).foregroundColor(Color.main3)
                        
                    }else{
                        
                        Text(" Days").font(.system(size: 80 )).foregroundColor(Color.main3)
                    }
                    
                }
                
                
                
                Spacer().frame(height: 100)
                
                
                if(loseWeight){
                    NavigationLink(destination: TabViewPage()) {
                        Text("Start Your Journey").padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(calorieGoal == "" || (Int(calorieGoal) ?? 0 > Int(calorieSpent))).simultaneousGesture(TapGesture().onEnded{
                        previousDay = .now
                        deficit = (Double(calorieSpent) - (Double(calorieGoal) ?? 0))
                        totalCalorieToLose -= 7700
                        UserDefaults.standard.welcomescreenShown = true
                    })

                    
                    
                }else{
                    NavigationLink(destination: TabViewPage()) {
                        Text("Start Your Journey").padding(15).background(Color.main2).cornerRadius(15).foregroundColor(Color.main3).shadow(radius: 2)
                    }.disabled(calorieGoal == "" || (Int(calorieGoal) ?? 0 < Int(calorieSpent)))
                        .simultaneousGesture(TapGesture().onEnded{
                            previousDay = .now
                            deficit = (Double(calorieSpent) - (Double(calorieGoal) ?? 0))
                            totalCalorieToLose -= 7700
                            UserDefaults.standard.welcomescreenShown = true
                        })
                   
                }
               
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
