//
//  CalculaltorViewController.swift
//  RPCalculator
//
//  Created by Rahul Sharma on 1/29/19.
//  Copyright © 2019 Rahul Patil. All rights reserved.
//

import UIKit

class CalculaltorViewController: UIViewController {

    // MARK:- Outlets -
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    //MARK:- Variables -
    private var viewModel = CalculatorViewModel()
    private var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            if let result = self.resultLabel.text, let returnValue = Double(result) {
                return returnValue
            }
            return 0
        }
        set {
            let temp = String(newValue).removeAfterPointIfZero()
            self.resultLabel.text = temp.setMaxLength(of: 15)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    //MARK: IBAction
    /// Touch Digits Button Action
    ///
    /// - Parameter sender: Digit Button
    @IBAction func touchDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        if self.userIsInTheMiddleOfTyping {
            if let textCurrentlyInDisplay = self.resultLabel.text {
                if digit == "." && (textCurrentlyInDisplay.range(of: ".") != nil) {
                    return
                } else {
                    let temp = textCurrentlyInDisplay + digit
                    self.resultLabel.text = temp.setMaxLength(of: 5)
                }
            }
        } else {
            if digit == "." {
                self.resultLabel.text = "0."
            } else {
                self.resultLabel.text = digit
            }
            self.userIsInTheMiddleOfTyping = true
        }
        self.calculationLabel.text = self.viewModel.description.last == "=" ? digit : self.viewModel.description
    }
    
    /// Perform Operation
    ///
    /// - Parameter sender: Operation Button
    @IBAction func performOperation(_ sender: UIButton) {
        if self.userIsInTheMiddleOfTyping {
            self.viewModel.setOperand(displayValue)
            self.userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            self.viewModel.performOperation(mathematicalSymbol)
        }
        if let result = viewModel.result {
            self.displayValue = result
            self.userIsInTheMiddleOfTyping = false
        }
        self.calculationLabel.text = self.viewModel.description
    }
}
