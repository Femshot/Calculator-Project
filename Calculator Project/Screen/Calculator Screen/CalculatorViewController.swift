//
//  CalculatorViewController.swift
//  Claculator Project
//
//  Created by MAC on 08/08/2025.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ACButton: CalculatorButton!
    @IBOutlet weak var backButton: CalculatorButton!
    var calculationString: String = "0"
    var calcList: [CalculationModel] = []
    var operationInProgress: Bool = false
    
    
    override func loadView() {
        super.loadView()
        setView()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(clearOnLongPress))
        longPress.minimumPressDuration = 1
        backButton.addGestureRecognizer(longPress)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // set calculation label to start right of screen
        scrollView.contentAlignmentPoint = CGPoint(x: 1.0, y: 0)
        
        if operationInProgress {
            backButton.layer.cornerRadius = backButton.frame.width / 2
            backButton.isHidden = false
            ACButton.isHidden = true
            view.layoutIfNeeded()
        } else {
            backButton.isHidden = true
            ACButton.isHidden = false
        }
    }
    
    
    @IBAction func numberPressed(_ sender: CalculatorButton) {
        
        let currentCharacter = sender.titleLabel?.text ?? ""
        
        
        if calculationLabel.text == "0" {
            if (isOperator(currentCharacter) && currentCharacter != "-" ) || currentCharacter == "." {
                calculationLabel.text! += currentCharacter
            } else {
                calculationLabel.text = currentCharacter
            }
            calculationString = calculationLabel.text!
        } else if resultLabel.text != " " && !isOperator(currentCharacter) && !operationInProgress {
            resultLabel.text = " "
            calculationLabel.text = currentCharacter
            calculationString = currentCharacter
        } else {
            
            if rejectMultiOperator(currentCharacter) {
                calculationLabel.text!.removeLast(1)
                calculationString.removeLast(1)
            }
            
            operationInProgress = true
            if resultLabel.text != " " {
                resultLabel.text = " "
            }
            
            if isOperator(currentCharacter) {
                
                if currentCharacter == "+/-" {
                    // handle number negation toggle
                    calculationString += "* -1"
                    calculationLabel.text = "(-\(calculationLabel.text!))"
                } else {
                     if currentCharacter == "%" {
                        // handle % modulo operation
                        calculationString += "/100"
                    } else {
                        calculationString += currentCharacter
                    }
                    calculationLabel.text! += currentCharacter
                }
                
            } else {
                calculationString += currentCharacter
                calculationLabel.text! += currentCharacter
            }
            
        }
        
        if scrollView.contentSize.width >= (scrollView.frame.width - 5) {
            updateCalcLabelScrollPosition()
        }
    }
    
    
    @IBAction func clearPressed(_ sender: CalculatorButton) {
        calculationLabel.text = "0"
        resultLabel.text = " "
        operationInProgress = false
    }
    
    
    @IBAction func deleteLastChar(_ sender: CalculatorButton) {
        // Limitations when perfoming '%' or '+/-' calculation operation
        
        if !operationInProgress || calculationLabel.text!.count <= 1 {
            if calculationLabel.text!.count == 1 {
                calculationLabel.text = "0"
            }
            backButton.isHidden = true
            ACButton.isHidden = false
            operationInProgress = false
            view.layoutIfNeeded()
            return
        }
        
        calculationLabel.text?.removeLast(1)
        calculationString.removeLast(1)
    }
    
    
    
    @IBAction func calculateResult(_ sender: CalculatorButton) {
        guard !isOperator(String(calculationString.last!)) && calculationString != "0" else { return }

        var equation = CalculationModel(calculation: calculationString, equation: calculationLabel.text!)
        
        do {
            try equation.solveCalculation()
        } catch CalculationErrors.invalidExpression {
            print("Couldn't evaluate input expression \"\(calculationString)\" to a meaningful value")
            return
        } catch {
            print("Unexpected Error")
            return
        }
        
        let result = equation.result
        resultLabel.text = calculationLabel.text
        calculationLabel.text = result
        calcList.append(equation)
        operationInProgress = false
        calculationString = result
    }
    
    
    @IBAction func viewHistory(_ sender: UIButton) {
        let vc = HistoryViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.passHistory(calcList)
        vc.delegate = self

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Half & Large screen
            sheet.prefersGrabberVisible = true // Optional pull handle
            sheet.prefersPageSizing = true
        }
        present(vc, animated: true)
    }
    
    private func rejectMultiOperator(_ current: String) -> Bool {

        guard let last = calculationLabel.text?.last else { return true }
        let prev = isOperator(String(last)) && String(last) != "%" //allow 30%+..
        let next = isOperator(current)
        
        // reject 30%%
        if String(last) == "%" && current == "%" {
            return true
        }
        
        return prev && next
    }
    
    private func isOperator(_ char: String) -> Bool {
        let operators: [String] = ["+", "-", "x", "÷", "*", "+/-", "%", "."]
        return operators.contains(char)
    }
    
    func updateCalcLabelScrollPosition() {
        // Scroll to the right (latest input at the edge)
        let offsetX = max(0, scrollView.contentSize.width - scrollView.frame.width)
        scrollView.setContentOffset(CGPoint(x: offsetX + 30.0, y: 0), animated: true)
        
    }
    
    @objc func clearOnLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            calculationLabel.text = "0"
            resultLabel.text = " "
            operationInProgress = false
        }
    }
    
}

extension CalculatorViewController: HistoryViewDelegate {
    
    private func setView() {
        var name = String(describing: type(of: self))
        name.removeLast("Controller".count)
        let nib = UINib(nibName: name, bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        
        if let firstView = views.first as? UIView {
            view = firstView
        }
    }
    
    func returnEquation(result: String, calculation: String) {
        calculationLabel.text = result
        calculationString = result
        resultLabel.text = calculation
    }
}
