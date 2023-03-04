//
//  LossOrGain.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 26.01.2023.
//
extension Color {
  
    public static var main1 : Color {
            return Color(UIColor(red: 0/255, green: 61/255, blue: 59/255, alpha: 1.0))
        }
    public static var main2 : Color {
            return Color(UIColor(red: 7/255, green: 130/255, blue: 126/255, alpha: 1.0))
        }
    public static var main3 : Color {
            return Color(UIColor(red: 161/255, green: 228/255, blue: 85/255, alpha: 1.0))
        }
   
    
}



import SwiftUI

struct LossOrGain: View {
    
   
    
    @AppStorage("loseWeight") var loseWeight: Bool = true
    @AppStorage("isEuUnits") var isEuUnits: Bool = true

    
    var body: some View {
        
   
            VStack(){
                Spacer()
                Text("Want to Lose Weight or Gain Weight?").font(.system(size: 20)).foregroundColor(Color.main3)
                Spacer().frame(height: 70)
                HStack{
                    
                    NavigationLink {
                    GenderChoiceView()
                    } label: {
                        Text("Lose Weight").padding().background(.blue).foregroundColor(.white).cornerRadius(25)
                    }.simultaneousGesture(TapGesture().onEnded{
                        loseWeight = true
                    })

                    Spacer().frame(width: 50)
                    NavigationLink {
                    GenderChoiceView()
                    } label: {
                        Text("Gain Weight").padding().background(.green).foregroundColor(.white).cornerRadius(25)
                    }.simultaneousGesture(TapGesture().onEnded{
                        loseWeight = false
                    })


                    
                
                }
                Spacer()
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.main1)
            .navigationTitle("Choose Your Goal")
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
