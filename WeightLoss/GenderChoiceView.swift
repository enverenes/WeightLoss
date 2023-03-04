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
            Spacer()
            HStack{
                
                NavigationLink {
                LoginView()
                } label: {
                    VStack{
                        Image("malegender").resizable().scaledToFit()
                        Text("Male").padding().foregroundColor(Color.main3)
                    }.frame(width: 120,height: 200).cornerRadius(15).padding()
                    
                }.simultaneousGesture(TapGesture().onEnded{
                   isMale = true
                })

                Spacer().frame(width: 50)
                NavigationLink {
                LoginView()
                } label: {
                    VStack{
                        Image("femalegender").resizable().scaledToFit()
                        Text("Female").padding().foregroundColor(Color.main3)
                    }.frame(width: 120,height: 200).cornerRadius(15).padding()
                    
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
