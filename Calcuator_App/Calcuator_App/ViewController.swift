//
//  ViewController.swift
//  Calcuator_App
//
//  Created by Bahaa Al juboori on 2022-09-20.
//
// Student Name: Carlos Hernandez Galvan
// Student ID: 301290263
//
// Student Name: Oscar Miralles Fernandez
// Student ID: 301250756
//
// Student Name: Bahaa Al-juboori
// Student ID: 3012869950
//
//This is a basic calculator app that incluides the operations +, -, *, / and %
//the caculator accuracy it's 12 decimal places.

import UIKit

class ViewController: UIViewController {
    //Inicialize variables
    var leftOperand: Float = 0.0
    var rightOperand: Float = 0.0
    var haveLeftOperand: Bool = false
    var haveRightOperand: Bool = false
    var resultLabelReady: Bool = true
    var result: Float = 0.0
    var activeOperator: String = ""
    //Herarchy operations variables
    var prevOperantHerarchy: Int = 0
    var currentOperantHerarchy: Int = 0
    var lastNumber: Float = 0.0
    var lastOperator: String = ""
    
    //Result Label
    @IBOutlet weak var ResultLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // Operator Functions
    //Add function
    func Add(lhs: Float, rhs: Float)->Float
    {
        return lhs + rhs
    }
    //Subtract function
    func Subtract(lhs: Float, rhs: Float) -> Float
    {
        return lhs - rhs
    }
    //multiply function
    func Multiply(lhs: Float, rhs: Float) -> Float
    {
        return lhs * rhs
    }
    //Divide function
    func Divide(lhs: Float, rhs: Float)->Float
    {
        return lhs / rhs
    }
    //Percentage function
    func Percentage(lhs: Float, rhs: Float)->Float
    {
        return (rhs / lhs) * 100
    }
    
    //Format de result to appropiate string and decimal places
    func FormatValue(value: String) -> String {
        var formatValue = value
        
        while formatValue.last == "0" {
            formatValue.removeLast()
        }

        if formatValue.last == "." {
            formatValue.removeLast()
        }
        
        return String(formatValue.prefix(12))
    }
    
    //Function to calculate operactions
    func Evaluate()
    {
        var resultStr = ""
        
        //Select operation clicked
        switch activeOperator
        {
        case "+":
            result = Add(lhs: leftOperand, rhs: rightOperand)
        case "-":
            result = Subtract(lhs: leftOperand, rhs: rightOperand)
        case "X":
            result = Multiply(lhs: leftOperand, rhs: rightOperand)
        case "/":
            result = Divide(lhs: leftOperand, rhs: rightOperand)
        case "%":
            result = Percentage(lhs: leftOperand, rhs: rightOperand)
        default:
            result = 0.0
        }
        
        //Inicialitze all the variables
        leftOperand = result
        rightOperand = 0.0
        haveLeftOperand = true
        haveRightOperand = false
        resultLabelReady = false
        activeOperator = ""
        
        //Format the result to appropiate string
        resultStr = String(result)
        ResultLabel.text = FormatValue(value: resultStr)
    }
    
    //Stablish the right herarchy for each operation to decide wich operations to do first
    func OperantHerarchy (value: String) -> Int {
        var herarchy: Int = 0
        
        switch value
        {
        case "+":
            herarchy = 2
        case "-":
            herarchy = 2
        case "x":
            herarchy = 1
        case "÷":
            herarchy = 1
        case "%":
            herarchy = 1
        default:
            herarchy = prevOperantHerarchy
        }
        
        return herarchy
    }
    
    // Handlers operation pressed
    @IBAction func OperatorButton_Pressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let currentInput = button.titleLabel!.text
        let resultLabelText = ResultLabel.text
        
        if(!haveLeftOperand)
        {
            leftOperand = Float(resultLabelText!)!
            haveLeftOperand = true
            resultLabelReady = false
        }
        else
        {
            if (resultLabelText != "0") {
                rightOperand = Float(resultLabelText!)!
                haveRightOperand = true
            }
            else {
                haveRightOperand = false
            }
        }
        
        //Herarcy decisions based on operation
        if (prevOperantHerarchy == 0) {
            prevOperantHerarchy = OperantHerarchy(value: currentInput!)
        }
        else {
            currentOperantHerarchy = OperantHerarchy(value: currentInput!)
        }
        
        if(haveLeftOperand && haveRightOperand && resultLabelReady)
        {
            //different behaviors based on the hierarchy of operations
            if (currentOperantHerarchy < prevOperantHerarchy) {
                lastNumber = leftOperand
                lastOperator = activeOperator
                leftOperand = rightOperand
                rightOperand = 0.0
                resultLabelReady = false
            }
            else {
                if (lastNumber != 0){
                    //Evaluate and restore the last operation values
                    Evaluate()
                    rightOperand = result
                    leftOperand = lastNumber
                    activeOperator = lastOperator
                }
                //Evaluate the las operation and clean it
                Evaluate()
                leftOperand = result
                rightOperand = 0.0
                lastNumber = 0.0
                lastOperator = ""
                prevOperantHerarchy = currentOperantHerarchy
                resultLabelReady = false
            }
        }
        
        switch currentInput
        {
        case "+":
            activeOperator = "+"
        case "-":
            activeOperator = "-"
        case "x":
            activeOperator = "X"
        case "÷":
            activeOperator = "/"
        case "%":
            activeOperator = "%"
        case "=":
            if (haveLeftOperand && haveRightOperand) {
                Evaluate()
                leftOperand = result
                rightOperand = 0.0
                resultLabelReady = false
            }
        default:
            print("Error!")
        }
    }
    
    //Handle number button pressed
    @IBAction func NumberButton_Pressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let currentInput = button.titleLabel!.text
        let resultLabelText = ResultLabel.text
        
        switch currentInput
        {
        case "0":
            if(resultLabelText != "0" && resultLabelReady)
            {
                ResultLabel.text?.append("0")
            }
            if (!resultLabelReady){
                ResultLabel.text = "0"
            }
        case ".":
            if(!resultLabelText!.contains("."))
            {
                ResultLabel.text?.append(".")
                resultLabelReady = true
            }
        default:
            if((resultLabelText == "0") || !resultLabelReady)
            {
                ResultLabel.text = ""
                resultLabelReady = true
            }
            if(resultLabelReady)
            {
                ResultLabel.text?.append(currentInput!)
            }
        }
    }
    
    //Handle delete button and clear all button
    @IBAction func ExtraButton_Pressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let currentInput = button.titleLabel!.text
        switch currentInput {
        case "AC":
            ResultLabel.text = "0"
            result = 0.0
            leftOperand = 0.0
            rightOperand = 0.0
            haveLeftOperand = false
            haveRightOperand = false
            activeOperator = ""
            //Clear herarchy variables
            prevOperantHerarchy = 0
            currentOperantHerarchy = 0
            lastNumber = 0.0
            lastOperator = ""
        default:
            if(ResultLabel.text!.count > 1)
            {
                ResultLabel.text?.removeLast()
            }
            else
            {
                ResultLabel.text = "0"
            }
        }
    }
}

