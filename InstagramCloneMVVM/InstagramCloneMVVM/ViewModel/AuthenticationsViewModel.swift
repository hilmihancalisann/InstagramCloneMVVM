//
//  AuthenticationsViewModel.swift
//  InstagramCloneMVVM
//
//  Created by Hilmihan Çalışan on 27.03.2023.
//


import UIKit


protocol FormViewModel {
    func updateForm()
}


protocol AuthenticationViewModel {
    var formIsVlid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}


struct LoginViewModel: AuthenticationViewModel {
   
    
    
    var email : String?
    var password: String?
    
    var formIsVlid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        
        return formIsVlid ? #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        
        
    }
    
    var buttonTitleColor: UIColor {
        
        return formIsVlid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}


struct RegisterViewModel: AuthenticationViewModel {
   
    
    var email : String?
    var password: String?
    var fullname : String?
    var username: String?
 
    var formIsVlid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsVlid ? #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        
    }
    
    var buttonTitleColor: UIColor {
        
        return formIsVlid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    
}
