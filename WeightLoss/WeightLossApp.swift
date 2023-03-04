//
//  WeightLossApp.swift
//  WeightLoss
//
//  Created by Enver Enes Keskin on 23.01.2023.
//

extension UIColor {
  
    public static var main1 : UIColor {
            return UIColor(red: 0/255, green: 61/255, blue: 59/255, alpha: 1.0)
        }
    public static var main2 : UIColor {
            return UIColor(red: 7/255, green: 130/255, blue: 126/255, alpha: 1.0)
        }
    public static var main3 : UIColor {
            return UIColor(red: 161/255, green: 228/255, blue: 85/255, alpha: 1.0)
        }
   
    
}

import SwiftUI

extension UserDefaults {
    var welcomescreenShown: Bool {
        get{
            return (UserDefaults.standard.bool(forKey: "welcomeScreenShown") as Bool?) ?? false
        }
        set{
            return (UserDefaults.standard.set(newValue,forKey: "welcomeScreenShown") )
        }
    }
}

@main
struct WeightLossApp: App {
    @AppStorage("darkMode") var darkMode = false

    init(){
       
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.main3]

            //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.main3]
        
       }
    
    var body: some Scene {
        WindowGroup {
            
            SplashScreenView().preferredColorScheme(darkMode ? .dark : .light)
        
        }
    }
}
