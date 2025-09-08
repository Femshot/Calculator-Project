//
//  optionsView.swift
//  Refined Quiz App
//
//  Created by MAC on 27/06/2025.
//

import UIKit

class RadioButton: UIView {
    
    @IBOutlet weak var middle: UIView!
    @IBOutlet weak var innermost: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setRadioButton()
    }
    
    private func setRadioButton() {
        middle.layer.cornerRadius = middle.frame.width/2.5
        innermost.layer.cornerRadius = innermost.frame.width/2.5
        innermost.isHidden = true
    }
    
}

extension RadioButton {
    
    func loadNib() {
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        
        if let view = views.first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            view.layer.cornerRadius = view.frame.width/2
            view.clipsToBounds = true
        }
    }
}
