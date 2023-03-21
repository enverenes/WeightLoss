//
//  GenderChoiceView.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 28.01.2023.
//

import SwiftUI

struct GenderChoiceView: View {
    @AppStorage("isMale") var isMale : Bool = true
    var body: some View {
        VStack(){
            Spacer().frame(height:150)
            HStack{
                
                NavigationLink {
                LoginView()
                } label: {
                    VStack{
                        Image("erkek").resizable().scaledToFit()
                        
                    }.frame(width: 140,height: 200).cornerRadius(15).padding()
                    
                }.simultaneousGesture(TapGesture().onEnded{
                   isMale = true
                })

                NavigationLink {
                LoginView()
                } label: {
                    VStack{
                        Image("kiz").resizable().scaledToFit()
                       
                    }.frame(width: 140,height: 200).cornerRadius(15).padding()
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    isMale = false
                })
                


                
            
            }
            Spacer()
            
               
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.main1).navigationTitle("Gender")
    }
}

struct GenderChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GenderChoiceView()
    }
}
