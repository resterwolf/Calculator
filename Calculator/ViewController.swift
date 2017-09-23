//
//  ViewController.swift
//  Calculator
//
//  Created by Vakhid Betrakhmadov on 20/09/2017.
//  Copyright © 2017 Vakhid Betrakhmadov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Sultan new comment
    //MARK: Properties
    @IBOutlet weak var display: UILabel!
    private var isInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            func hasDecimalPart(_ value: Double) -> Bool {
                return !(newValue == 0 || newValue.remainder(dividingBy: newValue.rounded()) == 0)
            }
            
            display.text =
                hasDecimalPart(newValue) ?
                String(newValue) :
                String(Int(newValue))
        }
    }
    
    //MARK: Actions
    @IBAction func touchDigit(_ sender: UIButton) {
    
        func add(next symbol: String, to displayValue: inout String) {
            if symbol == "." && displayValue.contains(".") {
                return
            }
            
            displayValue += symbol
        }
        
        if let digit = sender.currentTitle, display.text != nil {
            if !isInTheMiddleOfTyping {
                display.text = digit
                isInTheMiddleOfTyping = true
            } else {
                add(next: digit, to: &display.text!)
            }
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if isInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            isInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
}

