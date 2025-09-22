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
        let postUrl = "https://femi-awodele.app.n8n.cloud/webhook/1d6edf45-c92f-445d-a85e-d25d5b187505"
        guard let url = URL(string: postUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try? JSONEncoder().encode(calculations)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
            }
            
//            if let data {
//                let calcJson = try? JSONDecoder().decode([CalcHistoryModel].self, from: data)
//                
//                if let calcJson {
//                    for equa in calcJson {
//                        print("\(equa.equation!) = \(equa.result!)")
//                    }
//                }
//            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("✅ Status code:", statusCode)
            }
            
        }.resume()
        
//        let calc = try? JSONEncoder().encode(calculations)
//        
//        if let calc {
//            
//            // get swift object representation of data with right model
//            let calcJson = try? JSONDecoder().decode([CalcHistoryModel].self, from: calc)
//            if let calcJson {
//                for equa in calcJson {
//                    print("\(equa.equation!) = \(equa.result!)")
//                }
//            }
            
//            // get direct json string representation of data
//            let calcJson2 = try? JSONSerialization.jsonObject(with: calc, options: [])
//            if let calcJson2 {
//                print(calcJson2)
//            }
//        }
    }
}
