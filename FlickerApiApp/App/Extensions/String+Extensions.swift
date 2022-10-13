//
//  String+Extensions.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 13.10.2022.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@",passwordRegx).evaluate(with: password)
    }
    
    func getMissingValidation() -> [String] {
        var errors: [String] = []
        if(!NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: self)){
            errors.append("least one uppercase")
        }
        
        if(!NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self)){
            errors.append("least one digit")
        }

        if(!NSPredicate(format:"SELF MATCHES %@", ".*[!.&^%$#@()/]+.*").evaluate(with: self)){
            errors.append("least one symbol")
        }
        
        if(!NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: self)){
            errors.append("least one lowercase")
        }
        
        if(self.count < 8){
            errors.append("min 8 characters total")
        }
        return errors
    }
}
