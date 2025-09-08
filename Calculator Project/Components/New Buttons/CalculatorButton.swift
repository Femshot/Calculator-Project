//
//  CalculatorButton.swift
//  Claculator Project
//
//  Created by MAC on 11/08/2025.
//

import UIKit

class CalculatorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButton()
    }
    
    
    func setButton() {
        layer.cornerRadius = frame.width / 2
        titleLabel?.font = UIFont.systemFont(ofSize: 35)
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
//    func checkOrientation() {
//        
//        let deviceOrientation = UIDevice.current.orientation
//        
//        switch deviceOrientation {
//        case .portrait:
//            print("Device in Portrait")
//        case .landscapeLeft, .landscapeRight:
//            print("Device in Landscape")
//        case .portraitUpsideDown:
//            print("Upside Down")
//        default:
//            print("Unknown / FaceUp / FaceDown")
//        }
//    }
  

}
