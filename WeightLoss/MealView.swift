//
//  MealView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 1.02.2023.
//

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

import SwiftUI

struct MealView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    @State var showingPopup = false
    
    @State var mealNames: [String] = []
    @State var mealServings: [String] = []
    @State var mealCals: [String] = []
    
    @State var mealIndex: Int = 0
    @State var currentMealName = ""
    @State var currentClaorie = 0
    
    @State var servingCount = 1
    
    @AppStorage("todayMealCalories") var todayMealCalories : Int = 0
    
    
    
    func readCSV(inputFile: String){
            
           if let filepath = Bundle.main.path(forResource: inputFile, ofType: nil) {
               do {
                   let fileContent = try String(contentsOfFile: filepath)
                   let lines = fileContent.components(separatedBy: "\n")
                   
                   
                   
                   lines.dropFirst().forEach { line in
                       let data = line.components(separatedBy: ",")
                       if data.count == 3 {
                           mealNames.append(data[0])
                           mealServings.append(data[1])
                           mealCals.append(data[2])
                       }
                   }
                  
                  
               } catch {
                   print("error: \(error)") // to do deal with errors
               }
           } else {
               print("\(inputFile) could not be found")
           }
       
       }
     
   
    
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
                
                
                ForEach(mealNames.filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self){ mealname in
                    
                    HStack{
                        Button {
                            withAnimation{
                                showingPopup = true
                            }
                            
                            currentMealName = mealname
                            mealIndex = mealNames.firstIndex(of: mealname) ?? 0
                            currentClaorie = Int.parse(from: mealCals[mealIndex]) ?? 0
                            servingCount = 1
                        } label: {
                            Text(mealname).foregroundColor(.black)
                        }
                       Spacer()
                        
                    }.padding()
                    Divider().padding(.leading).background(Color(.systemGray4))
                }
                
                
            }.navigationTitle("Add Meal").onAppear{
            readCSV(inputFile: "calories.csv")
            }.blur(radius: (showingPopup) ? 15 : 0)
       
        if showingPopup{
           
               VStack{
                   Text(currentMealName).padding()
                   Divider().background(Color(.systemGray5)).frame(width: 100)
                   Spacer().frame(height: 20)
                   
                   HStack{
                       Spacer().frame(width: 20)
                       Text("Serving: ")
                       Text(mealServings[mealIndex])
                       Spacer()
                       Button {
                           servingCount += 1
                       } label: {
                           Image(systemName: "plus.circle").foregroundColor(Color(.systemBlue))
                       }
                      
                       Text("\(servingCount)").padding(.horizontal,8).padding(.vertical,6).background(Color(.systemBlue)).cornerRadius(5).foregroundColor(.white)
                       Spacer()
                   }
                    
                   
                   HStack{
                       Spacer().frame(width: 20)
                       Text("Calories:")
                       Text("\(servingCount*currentClaorie)")
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

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}
