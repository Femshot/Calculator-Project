//
//  HistoryViewController.swift
//  Claculator Project
//
//  Created by MAC on 11/08/2025.
//

import UIKit

protocol HistoryViewDelegate: AnyObject {
    func returnEquation(result: String, calculation: String)
}


class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var calcList: [CalcHistoryModel] = []
    weak var delegate: HistoryViewDelegate?
    var hideEditingButton: Bool = true // Aim to connect to Edit Button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 82
        
//        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        let nib = UINib(nibName: HistoryCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HistoryCell.identifier)
    }
    
    
    func passHistory(_ history: [CalculationModel]) {
        let calculations = history.reversed()
        calcList = calculations.map { model in
            return CalcHistoryModel(equation: model.equation, result: model.result)
        }
    }
    
    
    @IBAction func dissmissHistorypage(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func showEditRadioButtons(_ sender: Any) {
        
        hideEditingButton.toggle()
        tableView.reloadData()
    }
    
    @IBAction func uploadResults(_ sender: Any) {
        let dataToSend = UploadModel(calculations: calcList)
        dataToSend.uploadToServer()
    }
    
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setView() {
        var name = String(describing: type(of: self))
        name.removeLast("Controller".count)
        let nib = UINib(nibName: name, bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        
        if let firstView = views.first as? UIView {
            self.view = firstView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calcList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        
        let equation = calcList[indexPath.row]
        cell.updateLabels(result: equation.result ?? "", calculation: equation.equation ?? "")
        cell.toggleEditRadioButton(hideEditingButton)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let equation = calcList[indexPath.row]
        delegate?.returnEquation(result: equation.result ?? "", calculation: equation.equation ?? "")
        dismiss(animated: true)
    }

}

