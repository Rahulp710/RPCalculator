//
//  CalculatorViewModel.swift
//  RPCalculator
//
//  Created by Rahul Sharma on 1/29/19.
//  Copyright © 2019 Rahul Patil. All rights reserved.
//

import Foundation

class CalculatorViewModel {
    
    //MARK:- Enumerations -
    private enum Operation {
        case constant(Double)
        case binaryOperation((Double, Double) -> Double)
        case result
    }
    
    private var operations: Dictionary<String, Operation> = [
        "＋" : .binaryOperation({ $0 + $1 }),
        "﹣" : .binaryOperation({ $0 - $1 }),
        "×" : .binaryOperation({ $0 * $1 }),
        "÷" : .binaryOperation({ $0 / $1 }),
        "=" : .result
    ]
    
    //MARK:- Variables -
    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var resultIsPending = false
    
    var description = ""
    var result: Double? {
        get {
            return self.accumulator
        }
    }
    
    //MARK:- Embedded struct -
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return self.function(self.firstOperand, secondOperand)
        }
    }
    
    //MARK:- Functions -
    /// Perform pending Binary operation
    private func performPendingBinaryOperation() {
        if self.pendingBinaryOperation != nil,
            let accumulator = accumulator {
            self.accumulator = self.pendingBinaryOperation?.perform(with: accumulator)
            self.pendingBinaryOperation = nil
            self.resultIsPending = false
        }
    }
    
    /// Perform Operation with Symbol
    ///
    /// - Parameter symbol: symbol like +, -, x, ÷, =
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                description = ""
                
            case .binaryOperation(let function):
                self.performPendingBinaryOperation()
                if let accumulator = accumulator {
                    if self.description.last == "=" {
                        self.description = String(describing: accumulator).removeAfterPointIfZero().setMaxLength(of: 10) + symbol
                    } else {
                        description += symbol
                    }
                    self.pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator)
                    self.resultIsPending = true
                    self.accumulator = nil
                }
                
            case .result:
                self.performPendingBinaryOperation()
                if !self.resultIsPending {
                    if self.description.last != "=" {
                        self.description += "="
                    }
                }
            }
        }
    }
    
    /// Set operand
    ///
    /// - Parameter operand: operand
    func setOperand(_ operand: Double) {
        self.accumulator = operand
        if !self.resultIsPending {
            self.description = String(describing: operand).removeAfterPointIfZero().setMaxLength(of: 5)
        } else {
            self.description += String(describing: operand).removeAfterPointIfZero().setMaxLength(of: 5)
        }
    }
}
