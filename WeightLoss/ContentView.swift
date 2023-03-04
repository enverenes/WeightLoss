//
//  ContentView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 23.01.2023.
//

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}

import SwiftUI

struct ContentView: View {
    
    
    @State var textOp = 0.0
    @State var textPos = 0.0
    @State var deficitOp = 0.6
    @State var daydifference = 0
    @State var buttonDisabled = false
    @State var daysLeft: Int = 0
    @State var calorieForToday : String = ""
    @State var diffToday : Int = 0
    @State var showingSuccessPop : Bool = false
    @State var defaultGoal: Int = 0
    
  
    @AppStorage("deficit") var deficit : Double = 0.0
    @AppStorage("previousDay") var previousDay = Date()
    @AppStorage("initialDaysLeft") var initialDaysLeft: Int = 0
    @AppStorage("calorieSpent")var calorieSpent: Int = 0
    @AppStorage("calorieGoal") var calorieGoal : String = ""
    @AppStorage("weightDifference") var weightdifference: Int = 0
    @AppStorage("totalCalorieToLose") var totalCalorieToLose : Int = 0
    @AppStorage("initialCalorieToLose") var initialCalorieToLose : Int = 0
    @AppStorage("progress") var progress: Double = 0.0
    @AppStorage("premium") var isPremium: Bool = false
    
    
   
    
    func resetProgress() {
        self.progress = 0
        }
    func addToProgress(added: Double) {
        self.progress = self.progress + added
        }
    
    func getDay() {
        let today = Date.now
        let diff = Calendar.current.dateComponents([.day], from: previousDay, to: today).day!
        
        if(diff == 0){
            print("sameday")
        }else{
            print(diff)
            previousDay = today
            totalCalorieToLose = totalCalorieToLose - (7700 * diff)
            calorieForToday = calorieGoal
   
            defaultGoal = (Int(calorieGoal) ?? 0)
            if totalCalorieToLose <= 0 {
                totalCalorieToLose = 0
                showingSuccessPop = true
                print("Goal Achieved")
            }
        }
       
    }
    
    
    func recalculateDays(caloriegoaltoday: Int) {
     
       
       diffToday = defaultGoal - caloriegoaltoday
        print(diffToday)
        
       totalCalorieToLose -= diffToday
        
        defaultGoal = caloriegoaltoday
        if totalCalorieToLose > initialCalorieToLose {
           
            totalCalorieToLose = initialCalorieToLose
            defaultGoal = Int(calorieGoal) ?? 0
        }else {
           
          
        }
        
        if totalCalorieToLose <= 0 {
            totalCalorieToLose = 0
            showingSuccessPop = true
            print("Goal Achieved")
        }
     
    }
    
    func calculateTotalCal(weightdiff: Int) -> Int{
        
        totalCalorieToLose = 7700 * weightdiff
        
        return totalCalorieToLose
    }
    
    func calculateDays() ->Int{
        var days: Double = (Double(totalCalorieToLose) / deficit)
        
        return Int(days.rounded())
    }
    
    var body: some View {
       
        ZStack{
            
            if showingSuccessPop {
                VStack{
                    
                    Text("Congrats!")
                    Button {
                        showingSuccessPop = false
                    } label: {
                        Text("OK")
                    }

                    
                }.frame(width: 300, height: 200, alignment: .center).background(Color(.systemGray5)).cornerRadius(15).font(.system(size: 20))
                
            }
           
            VStack{
                Spacer()
                Text("Calorie deficit: \(Int(deficit))")
                    .padding()
                    .font(.system(size: 20))
                    .background(Color.main3).cornerRadius(15)
                    .opacity(deficitOp).animation(Animation.easeIn(duration: 1.0).repeatForever(autoreverses: true), value: deficitOp)
                    .frame(maxWidth: .infinity,alignment: .center).foregroundColor(.black)
                
                Spacer()
                ZStack() {
                    Circle()
                        .stroke(
                            Color.main3.opacity(0.5),
                            lineWidth: 30
                        )
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.main3,
                            style: StrokeStyle(
                                lineWidth: 30,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                    // 1
                        .animation(.easeOut, value: progress)
                    
                    Text("\(calculateDays()) days left").font(.system(size: 40 )).frame(width: 200).multilineTextAlignment(.center)
                    
                    Text("\(diffToday) Calories").padding().background(.red).foregroundColor(.white).cornerRadius(10).opacity(textOp)
                        .animation(Animation.easeInOut(duration: 0.5), value: textOp)
                        .offset(y: textPos).animation(Animation.easeInOut(duration: 0.5), value: textPos)
                    
                    
                }
                .frame(width: 250.0, height: 250.0)
                Spacer()
                
                VStack(){
                    Text("Today's Calorie Intake")
                    
                    HStack{
                        TextField("", text: $calorieForToday)
                            .keyboardType(.numberPad)
                            .onReceive(calorieForToday.publisher.collect()) {
                                   self.calorieForToday = String($0.prefix(5))
                               }
                            .multilineTextAlignment(.center)
                            .font(.title2)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .strokeBorder(Color(.systemGray).opacity(0.5), lineWidth: 1))
                            .frame(width: 200)
                        
                        Button {
                            
                            buttonDisabled = true
                            recalculateDays(caloriegoaltoday: Int(calorieForToday) ?? 0)
                            textOp = 1.0
                            textPos = -30
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                textOp = 0.0
                                textPos = -60
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    textOp = 0.0
                                    textPos = 0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        
                                        buttonDisabled = false
                                    }
                                    
                                }
                            }
                            
                            
                            progress = 1 -  (Double(totalCalorieToLose) / Double(initialCalorieToLose))
                        } label: {
                            Text("Save").padding().background(Color.main2).foregroundColor(.white).cornerRadius(15)
                        }.disabled(buttonDisabled)
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                Spacer()
                
                ZStack{
                    
                    
                    HStack{ NavigationLink(destination: CalorieIntakeView()) {
                        Text("Add Exercise").padding(15).background(.white).cornerRadius(15).foregroundColor(.black).shadow(radius: 1)
                    }.disabled(!(isPremium)).simultaneousGesture(TapGesture().onEnded{
                        
                        
                    })
                        
                        Spacer().frame(width: 40)
                            .frame(height: 30.0)
                        NavigationLink(destination: MealView()) {
                            Text("Add Meal").padding(15).background(.white).cornerRadius(15).foregroundColor(.black).shadow(radius: 1)
                        }.disabled(!(isPremium)).simultaneousGesture(TapGesture().onEnded{
                            
                            
                        })
                        
                        
                    }.blur(radius: (isPremium) ? 0 : 15)
                    
                    
                    HStack{
                        if !isPremium {
                            NavigationLink {
                                PremiumView()
                            } label: {
                                Image(systemName: "lock").resizable()
                                    .scaledToFit()
                                    .frame(width: 50,height: 50).foregroundColor(Color(.systemGray))
                            }
                        }
                    }
                    
                }
                
                Spacer()
                
                
                
            }.blur(radius: (showingSuccessPop) ? 15 : 0)
            .onAppear(){
                getDay()
                progress = 1 - (Double(totalCalorieToLose) / Double(initialCalorieToLose))
                UserDefaults.standard.welcomescreenShown = true
                deficitOp = 0.9
                    
                
              
            }
            .navigationBarBackButtonHidden(true)
            
        }
            
    }
           
    }
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



    
    
