//
//  ExerciseView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 1.02.2023.
//

import SwiftUI

struct ExerciseView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    @State var showingPopup = false
  
  
    @State var exerciseIndex: Int = 0
    @State var currentExerciseName = ""
    @State var currentClaorie = 0
    
   
    
    @AppStorage("todayExerciseCalories") var todayExerciseCalories : Int = 0
    
    
 @State  var exerciseNames = [
        "Running",
        "Jumping jacks",
        "Push-ups",
        "Sit-ups",
        "Squats",
        "Burpees",
        "Cycling",
        "Swimming",
        "Rowing",
        "Jump rope",
        "Yoga"
    ]

  @State var exerciseCals = [
        "Running": 10,
        "Jumping jacks": 8,
        "Push-ups": 6,
        "Sit-ups": 7,
        "Squats": 9,
        "Burpees": 10,
        "Cycling": 8,
        "Swimming": 10,
        "Rowing": 8,
        "Jump rope": 12,
        "Yoga": 5
    ]
    
    let exerciseIcons = [
        "Running": "🏃‍♂️",
        "Jumping jacks": "🤸‍♂️",
        "Push-ups": "💪",
        "Sit-ups": "🧘‍♂️",
        "Squats": "🏋️‍♂️",
        "Burpees": "🦍",
        "Cycling": "🚴‍♂️",
        "Swimming": "🏊‍♂️",
        "Rowing": "🚣‍♂️",
        "Jump rope": "🪢",
        "Yoga": "🧘‍♀️"
    ]

    
    var body: some View {
        ZStack{
            
          ScrollView{
                
                HStack{
                    HStack{
                        TextField("Search food ", text: $searchText).padding(8).padding(.leading, 36)
                        
                    }.background(Color(.systemGray5))
                        .onTapGesture(perform: {
                            withAnimation{
                                isSearching = true
                            }
                            
                        })
                        .cornerRadius(8)
                        .padding()
                        .overlay(
                            HStack{
                                    Image(systemName: "magnifyingglass")
                                    Spacer()
                                
                                if isSearching{
                                    Button {
                                        searchText = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.black)
                                    }
      
                                }
                             }.padding(.horizontal,30)
                            )
                    
                    if isSearching{
                        Button {
                            withAnimation{
                                isSearching = false
                            }
                            
                            searchText = ""
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        } label: {
                            Text("Cancel").padding(.trailing)
                        }
                    }
                    

                }
                
                
                ForEach(exerciseNames.filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self){ exercisename in
                    
                    HStack{
                       
                        Button {
                            withAnimation{
                                showingPopup = true
                            }
                            
                            currentExerciseName = exercisename
                            currentClaorie =  exerciseCals[exercisename] ?? 0
                        
                        } label: {
                            Text(exerciseIcons[exercisename] ?? "")
                            Text(exercisename).foregroundColor(.black)
                        }
                       Spacer()
                        
                        Text("\(exerciseCals[exercisename] ?? 0) calories / hour")
                        Spacer().frame(width: 20)
                    }.padding()
                    Divider().padding(.leading).background(Color(.systemGray4))
                }
                
                
            }.navigationTitle("Add Meal").onAppear{
          
            }.blur(radius: (showingPopup) ? 15 : 0)
       
        if showingPopup{
           
               VStack{
                   Text(currentExerciseName).padding()
                   Divider().background(Color(.systemGray5)).frame(width: 100)
                   Spacer().frame(height: 20)
                   
                   HStack{
                       Spacer().frame(width: 20)
                       Text("Serving: ")
                       
                       Spacer()
                       Button {
                           
                           
                       } label: {
                           Image(systemName: "plus.circle").foregroundColor(Color(.systemBlue))
                       }
                      
                       Text("").padding(.horizontal,8).padding(.vertical,6).background(Color(.systemBlue)).cornerRadius(5).foregroundColor(.white)
                       Spacer()
                   }
                    
                   
                   HStack{
                       Spacer().frame(width: 20)
                       Text("Calories:")
                       Text("")
                       Spacer()
                        
                   }
                   HStack{
                       Spacer()
                       Button {
                           withAnimation{
                               
                               showingPopup = false
                           }
                           
                       } label: {
                           Text("Add").foregroundColor(Color(.systemBlue))
                       }.padding(.trailing,15)
                   }
                 

               }.frame(width: 300, height: 200, alignment: .center).background(Color(.systemGray5)).cornerRadius(15).font(.system(size: 20))
            }
            
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
