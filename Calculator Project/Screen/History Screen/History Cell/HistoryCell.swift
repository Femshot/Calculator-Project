//
//  HistoryCell.swift
//  Claculator Project
//
//  Created by MAC on 12/08/2025.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    static let identifier: String = "HistoryCell"
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var editRadioButton: RadioButton!
    
//Best use for custom cells without any custom user control/interaction elements
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setView()
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideInnermost))
//        editRadioButton.addGestureRecognizer(gesture)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideInnermost))
        editRadioButton.addGestureRecognizer(gesture)
    }
    
    
    func updateLabels(result: String, calculation: String) {
        resultLabel.text = result
        calculationLabel.text = calculation
    }
    
    func toggleEditRadioButton(_ editState: Bool) {
        editRadioButton.isHidden = editState
    }
        
    @objc func hideInnermost() {
        editRadioButton.innermost.isHidden.toggle()
    }

}

//extension HistoryCell {
//    private func setView() {
//        let name = String(describing: type(of: self))
//        let nib = UINib(nibName: name, bundle: nil)
//        let views = nib.instantiate(withOwner: self, options: nil)
//        
//        if let firstView = views.first as? UIView {
//            addSubview(firstView)
//            firstView.frame = bounds
//            firstView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            firstView.clipsToBounds = true
//        }
//    }
//}
