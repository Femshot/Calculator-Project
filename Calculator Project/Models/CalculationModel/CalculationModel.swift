//
//  CalculationModel.swift
//  Claculator Project
//
//  Created by MAC on 11/08/2025.
//

import Foundation

struct CalculationModel {
    let calculation: String
    let equation: String
    
    var result: String = ""

    mutating func solveCalculation() throws {
        //        let exp = NSExpression(format:calculation)
        //
        //        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
        //            return result.stringValue
        //        }
        //        return nil
                

        let expression = calculation

        // 1. Regex: match numbers (int or decimal) or operators
        let pattern = #"\d+(\.\d+)?|[+\-*/x÷]"#
        let regex = try! NSRegularExpression(pattern: pattern)

        // 2. Tokenize
        let matches = regex.matches(in: expression, range: NSRange(expression.startIndex..., in: expression))
                var tokens = matches.map { String(expression[Range($0.range, in: expression)!]) }

        // 3. Convert integers to decimal form
        tokens = tokens.map { token in
            if let _ = Double(token), !token.contains(".") {
                return token + ".0"
            } else if token == "x" {
                return "*"
            } else if token == "÷" {
                return "/"
            }
            return token
        }

//        print(tokens)

        // 4. Recombine for NSExpression
        let decimalExpression = tokens.joined()
        
        // 5. perform evaluation
        if let expr = ExceptionCatcher.catchException(withFormat: decimalExpression) {
            if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                self.result = result.stringValue
            }
        } else {
            throw CalculationErrors.invalidExpression
        }
    }
}
