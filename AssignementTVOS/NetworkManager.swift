//
//  NetworkManager.swift
//  AssignementTVOS
//
//  Created by Abhilash k George on 27/12/22.
//

import Foundation

class NetworkManager {
    
    var universities: [University] = []
    
    func fetchUniversities(url:URL, completion: @escaping ([University]) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching universities: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data returned from API")
                    return
                }
                

                self.universities = self.parseUniversities(data: data)

                DispatchQueue.main.async {
                    completion(self.universities)
                }
            }
            task.resume()
        }
    
    func parseUniversities(data: Data) ->  [University] {
        
        var university = [University]()

        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
        
        guard let jsonArray = jsonObject as? [[String: Any]] else {
            return []
        }
        
        for json in jsonArray {
            if let name = json["name"] as? String, let country = json["country"] as? String {
                let uni = University(name: name, country: country)
                university.append(uni)
                
            }
        }
        
        
        return university
    }

}
