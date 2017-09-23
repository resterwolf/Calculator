//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Vakhid Betrakhmadov on 21/09/2017.
//  Copyright © 2017 Vakhid Betrakhmadov. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        return accumulator
    }
    
    private enum Operation {
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private let operations: [String : Operation] = [
        "√" : .unaryOperation(sqrt),
        "cos" : .unaryOperation(cos),
        "±" : .unaryOperation(-),
        "+" : .binaryOperation(+),
        "-" : .binaryOperation(-),
        "×" : .binaryOperation(*),
        "÷" : .binaryOperation(/),
        "=" : .equals,
        "AC": .clear
    ]
    
    private var holder: (operand: Double, binaryFunction: (Double,Double) -> Double )?
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .unaryOperation(let unaryFunction) where accumulator != nil:
                accumulator = unaryFunction(accumulator!)
                holder = nil
            case .binaryOperation(let binaryFunction) where accumulator != nil:
                if holder != nil {
                    accumulator = holder!.binaryFunction(holder!.operand,accumulator!)
                    holder = nil
                }
                holder = (accumulator!, binaryFunction)
            case .equals where accumulator != nil && holder != nil:
                accumulator = holder!.binaryFunction(holder!.operand,accumulator!)
                holder = nil
            case .clear:
                accumulator = 0
                holder = nil
            default:
                break
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    
}
