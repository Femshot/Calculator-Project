//
//  UploadModel.swift
//  Claculator Project
//
//  Created by MAC on 13/08/2025.
//

import Foundation

struct UploadModel {
    
    let calculations: [CalcHistoryModel]
    
    func uploadToServer() {
//        guard let url = URL(string: "https//fakesite.com") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "content-type")
//        request.httpBody = try? JSONEncoder().encode(calculations)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let error {
//                print(error.localizedDescription)
//            }
//            
//            if let data {
//                let calcJson = try? JSONDecoder().decode([CalculationModel].self, from: data)
//                
//                if let calcJson {
//                    for equa in calcJson {
//                          print("\(equa.calculation) = \(equa.result!)")
//                    }
//                }
//            }
//        }.resume()
        
        let calc = try? JSONEncoder().encode(calculations)
        
        if let calc {
            
            // get swift object representation of data with right model
            let calcJson = try? JSONDecoder().decode([CalcHistoryModel].self, from: calc)
            if let calcJson {
                for equa in calcJson {
                    print("\(equa.equation!) = \(equa.result!)")
                }
            }
            
            // get direct json string representation of data
            let calcJson2 = try? JSONSerialization.jsonObject(with: calc, options: [])
            if let calcJson2 {
                print(calcJson2)
            }
        }
    }
}
