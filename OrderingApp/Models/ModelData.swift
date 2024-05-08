//
//  ModelData.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import Foundation

class ModelData: ObservableObject {
    @Published var products: [Product] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "coffeedb", withExtension: "json")
        else {
            print("JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.products = try decoder.decode([Product].self, from: data)
        }
        catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
