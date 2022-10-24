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
    
    //Stacks for operations, operands and memory
    var leftOperatorsStack: [Float] = []
    var rightOperatorsStack: [Float] = []
    var operandsStack: [String] = []
    //LIFO memory stack
    var memoryStack: [Float] = []
    
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
    func Divide(lhs: Float, rhs: Float) -> Float
    {
        return lhs / rhs
    }
    //Percentage function
    func Percentage(lhs: Float, rhs: Float) -> Float
    {
        if (rhs != 0) {
            return lhs * (rhs / 100)
        }
        else
        {
            return lhs / 100
        }
    }
    //Sinus function
    func Sinus(lhs: Float) -> Float
    {
        return (sin(lhs * Float(Double.pi) / 180))
    }
    //Cosinus function
    func Cosinus(lhs: Float) -> Float
    {
        return (cos(lhs * Float(Double.pi) / 180))
    }
    //Tangent function
    func Tangent(lhs: Float) -> Float
    {
        return (tan(lhs * Float(Double.pi) / 180))
    }
    //Sinh function
    func Asinus(lhs: Float) -> Float
    {
        return (sinh(lhs))
    }
    //Cosh function
    func Acosinus(lhs: Float) -> Float
    {
        return (cosh(lhs))
    }
    //Tanh function
    func Atangent(lhs: Float) -> Float
    {
        return (tanh(lhs))
    }
    //Logarithm function
    func Logarithm(lhs: Float) -> Float
    {
        return (log10(lhs))
    }
    //Logarithm natural function
    func LogarithmN(lhs: Float) -> Float
    {
        return (log(lhs))
    }
    //Square function
    func Square(lhs: Float) -> Float
    {
        return (pow(lhs,2))
    }
    //Square 3 function
    func SquareThree(lhs: Float) -> Float
    {
        return (pow(lhs,3))
    }
    //Power function
    func Power(lhs: Float, rhs: Float) -> Float
    {
        if (rhs != 0) {
            return (pow(lhs,rhs))
        }
        else
        {
            return(lhs)
        }
    }
    //Square root function
    func SquareR(lhs: Float) -> Float
    {
        return (sqrtf(lhs))
    }
    //Power root function
    func PowerRoot(lhs: Float, rhs: Float) -> Float
    {
        if (rhs != 0) {
            return (pow(lhs,1/rhs))
        }
        else
        {
            return(lhs)
        }
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
        case "sin":
            result = Sinus(lhs: leftOperand)
        case "cos":
            result = Cosinus(lhs: leftOperand)
        case "tan":
            result = Tangent(lhs: leftOperand)
        case "sinh":
            result = Asinus(lhs: leftOperand)
        case "cosh":
            result = Acosinus(lhs: leftOperand)
        case "tanh":
            result = Atangent(lhs: leftOperand)
        case "log":
            result = Logarithm(lhs: leftOperand)
        case "ln":
            result = LogarithmN(lhs: leftOperand)
        case "sq2":
            result = Square(lhs: leftOperand)
        case "sq3":
            result = SquareThree(lhs: leftOperand)
        case "sqy":
            result = Power(lhs: leftOperand, rhs: rightOperand)
        case "sqr":
            result = SquareR(lhs: leftOperand)
        case "sqry":
            result = PowerRoot(lhs: leftOperand, rhs: rightOperand)
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
        
        //Add result to left operant stack
        leftOperatorsStack.append(leftOperand)
        
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
        case "X":
            herarchy = 1
        case "/":
            herarchy = 1
        case "sqy":
            herarchy = 1
        case "sqry":
            herarchy = 1
        default:
            herarchy = 0
        }
        
        return herarchy
    }
    
    //Shunting yard algorithm variant
    //Stack evaluation with priorities
    //If we have same herarchy operations we have one operation in out stack. Otherwise, we have two operations
    func DecisionStack () -> Bool{
        //One operant in stack decision
        if (operandsStack.count == 1) {
            if (OperantHerarchy(value: operandsStack[0]) == 0) {
                leftOperand = leftOperatorsStack[0]
                rightOperand = 0.0
                activeOperator = operandsStack[0]
                Evaluate()
                rightOperand = 0.0
                leftOperand = 0.0
                haveLeftOperand = false
                haveRightOperand = false
                operandsStack.removeAll()
                leftOperatorsStack.removeAll()
                rightOperatorsStack.removeAll()
            }
            else {
                leftOperand = leftOperatorsStack[0]
                rightOperand = rightOperatorsStack[0]
                activeOperator = operandsStack[0]
                Evaluate()
                leftOperand = result
                rightOperand = 0.0
                haveLeftOperand = false
                haveRightOperand = false
                operandsStack.removeAll()
                leftOperatorsStack.removeAll()
                rightOperatorsStack.removeAll()
            }
        }
        else {
            //Mora than one operant decision
            //In the event that we have pending operations of equal herarchy
            if (operandsStack.count > 1) {
                if (OperantHerarchy(value: operandsStack[0]) ==
                    OperantHerarchy(value: operandsStack[1])) {
                    leftOperand = leftOperatorsStack[0]
                    rightOperand = rightOperatorsStack[0]
                    activeOperator = operandsStack[0]
                    Evaluate()
                    operandsStack.removeFirst()
                    leftOperatorsStack.removeFirst()
                    rightOperatorsStack.removeFirst()
                    leftOperand = result
                    rightOperand = 0.0
                }
                else {
                    //In the event that we have pending operations of 0 hierarchy
                    if (OperantHerarchy(value: operandsStack[1]) == 0)
                    {
                        leftOperand = leftOperatorsStack[0]
                        rightOperand = rightOperatorsStack[0]
                        activeOperator = operandsStack[1]
                        Evaluate()
                        rightOperatorsStack[0] = result
                        leftOperatorsStack.removeLast()
                        rightOperatorsStack.removeLast()
                        operandsStack.remove(at: 1)
                        leftOperand = result
                        rightOperand = 0.0
                        return true
                    }
                    else
                    {
                        //Diferent herarchy cases. Herarchy 1 cases
                        if (rightOperatorsStack.count > 1){
                            leftOperand = rightOperatorsStack[0]
                            rightOperand = rightOperatorsStack[1]
                            activeOperator = operandsStack[1]
                            Evaluate()
                            rightOperatorsStack[0] = result
                            leftOperatorsStack.remove(at: 1)
                            operandsStack.remove(at: 1)
                            rightOperatorsStack.remove(at: 1)
                            rightOperand = result
                            leftOperand = 0.0
                        }
                    }
                }
            }
        }
        
        //Recall in case of pending operations in the stack with same herarchy
        if ((operandsStack.count > 1) &&
            (OperantHerarchy(value: operandsStack[0]) ==
            OperantHerarchy(value: operandsStack[1]))){
            resultLabelReady = DecisionStack()
        }
    
        return false
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
            
            //Add Left stack
            leftOperatorsStack.append(Float(resultLabelText!)!)
            
            haveLeftOperand = true
            resultLabelReady = false
        }
        else
        {
            if (resultLabelText != "0") {
                rightOperand = Float(resultLabelText!)!
                
                //Add Right stack
                rightOperatorsStack.append(Float(resultLabelText!)!)
                
                haveRightOperand = true
            }
            else {
                haveRightOperand = false
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
        case "sin":
            activeOperator = "sin"
        case "cos":
            activeOperator = "cos"
        case "tan":
            activeOperator = "tan"
        case "sinh":
            activeOperator = "sinh"
        case "cosh":
            activeOperator = "cosh"
        case "tanh":
            activeOperator = "tanh"
        case "log":
            activeOperator = "log"
        case "ln":
            activeOperator = "ln"
        case "sq2":
            activeOperator = "sq2"
        case "sq3":
            activeOperator = "sq3"
        case "sqy":
            activeOperator = "sqy"
        case "sqr":
            activeOperator = "sqr"
        case "sqry":
            activeOperator = "sqry"
        case "=":
            if (haveLeftOperand && haveRightOperand) {
                while (!operandsStack.isEmpty) {
                    resultLabelReady = DecisionStack()
                }
                activeOperator = ""
                resultLabelReady = false
            }
        default:
            print("Error!")
        }
        
        //Add operator stack
        if (activeOperator != ""){
            operandsStack.append(activeOperator)
        }
        
        if (!operandsStack.isEmpty) {
            if((haveLeftOperand && haveRightOperand && resultLabelReady) ||
               OperantHerarchy(value: operandsStack[0]) == 0)
            {
                resultLabelReady = DecisionStack()
            }
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
    
    //Handle delete button and clear all button and special operations
    //in extended version
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
            //Clear stacks
            leftOperatorsStack = []
            rightOperatorsStack = []
            operandsStack = []
        case "chs":
            //Change the calcul sign
            ResultLabel.text = FormatValue(value: String(Float(ResultLabel.text!)! * -1))
        case "mc":
            //Memory stack clear
            if (!memoryStack.isEmpty) { memoryStack.removeAll() }
        case "m+":
            //Memory stack append
            memoryStack.append(Float(ResultLabel.text!)!)
        case "m-":
            //Memory stack delete element
            if (!memoryStack.isEmpty) { memoryStack.removeLast() }
        case "mr":
            //Memory stack retrieve
            if (!memoryStack.isEmpty) {
                ResultLabel.text = FormatValue(value: String(memoryStack[memoryStack.count - 1]))
            }
        case "e":
            ResultLabel.text = FormatValue(value: String(2.718281828459045))
        case "π":
            ResultLabel.text = FormatValue(value: String(Double.pi))
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

