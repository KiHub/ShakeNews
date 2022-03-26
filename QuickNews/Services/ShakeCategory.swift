//
//  ShakeCategory.swift
//  ShakeNews
//
//  Created by  Mr.Ki on 26.03.2022.
//

import Foundation

class Shake {
    
   static let shake = Shake()
    

var categoryNumber = 0

let categoryArray = [
"general",
"business",
"entertainment",
"health",
"science",
"sports",
"technology"]

func changeCategory() {
    if categoryNumber != 6 {
        categoryNumber += 1
    } else {
        categoryNumber = 0
    }
}

}
