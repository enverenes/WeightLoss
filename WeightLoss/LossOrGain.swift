//
//  LossOrGain.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 26.01.2023.
//
extension Color {
  
   /* public static var main1 : Color {
            return Color(UIColor(red: 0/255, green: 61/255, blue: 59/255, alpha: 1.0))
        }
    public static var main2 : Color {
            return Color(UIColor(red: 7/255, green: 130/255, blue: 126/255, alpha: 1.0))
        }
    public static var main3 : Color {
            return Color(UIColor(red: 161/255, green: 228/255, blue: 85/255, alpha: 1.0))
        }
   */
    public static var main1 : Color {
        return Color(UIColor(red: 40/255, green: 84/255, blue: 48/255, alpha: 1.0))
        }
    public static var main2 : Color {
            return Color(UIColor(red: 95/255, green: 141/255, blue: 78/255, alpha: 1.0))
        }
    public static var main3 : Color {
        return Color(UIColor(red: 229/255, green: 217/255, blue: 182/255, alpha: 1.0))
        }
}



import SwiftUI

struct LossOrGain: View {
    
   
    
    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("isEuUnits") var isEuUnits: Bool = true
    
    
    
    
    
    var body: some View {
        
   
            VStack(){
                Spacer().frame(height:200)
                Text("What is your goal?").font(.largeTitle).foregroundColor(Color.main3)
                Spacer().frame(height: 70)
                HStack{
                    
                    NavigationLink {
                    GenderChoiceView()
                    } label: {
                        Text("Lose Weight").padding().background(Color.main3).foregroundColor(.main2).cornerRadius(25)
                    }.simultaneousGesture(TapGesture().onEnded{
                        loseWeight = true
                    })

                    Spacer().frame(width: 35)
                    NavigationLink {
                    GenderChoiceView()
                    } label: {
                        Text("Gain Weight").padding().background(Color.main2).foregroundColor(.main3).cornerRadius(25)
                    }.simultaneousGesture(TapGesture().onEnded{
                        loseWeight = false
                    })


                    
                
                }
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.main1)
            .navigationTitle("Choose Your Goals")
        .onAppear(){
            
            
            let locale = Locale.current
            if locale.language.region?.identifier == "US" {
               
               isEuUnits = false
            }
            
        }
        .accentColor(Color.main3)
        
    }
}

struct LossOrGain_Previews: PreviewProvider {
    static var previews: some View {
       LossOrGain()
       
    }
}
