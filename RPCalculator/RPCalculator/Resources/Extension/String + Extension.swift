//
//  String + Extension.swift
//  RPCalculator
//
//  Created by Rahul Sharma on 1/29/19.
//  Copyright © 2019 Rahul Patil. All rights reserved.
//

import Foundation

extension String {
    
    /// Set the max length of the number to display as result
    ///
    /// - Parameter maxLength: maximum length of string
    /// - Returns: result string
    func setMaxLength(of maxLength: Int) -> String {
        var temp = self
        if temp.contains("e") {
            return temp
        } else if temp.count > maxLength {
            var numbers = temp.map { $0 }
            if numbers[maxLength - 1] == "." {
                numbers.removeSubrange(maxLength+1..<numbers.endIndex)
            } else {
                numbers.removeSubrange(maxLength..<numbers.endIndex)
            }
            temp = String(numbers)
        }
        return temp
    }
    
    /// Remove the '.0' when the number is not decimal
    ///
    /// - Returns: number string
    public func removeAfterPointIfZero() -> String {
        let stringArray = self.components(separatedBy: ".")
        if stringArray.count == 2 {
            switch stringArray.last {
            case "0", "00", "000", "0000", "00000", "000000":
                return stringArray.first! // stringArry count is 2 so I am sure that stringArry.first has value.
            default:
                return self
            }
        }
        return self
    }
}
