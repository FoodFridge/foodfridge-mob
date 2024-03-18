//
//  AddPantryViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/6/24.
//

import Foundation
import Combine

class AddPantryViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var suggestions: [String] = []
        @Published var httpResponseCode: Int = 0
        @Published var feedBack = ""
    
        private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        $searchText
                    .removeDuplicates()
                    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                    .sink { [weak self] query in
                        self?.performSearch(query: query)
                    }
                    .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        // Use Task.init to bridge to async code

        // Check if the query string is empty and return early if it is
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.suggestions = []
            return
            
        }
            Task {
                do {
                    let searchResults = try await search(query: query)
                    DispatchQueue.main.async { [weak self] in
                        self?.suggestions = searchResults
                    }
                } catch {
                    // Handle errors, possibly setting an error state or logging
                    print("An error occurred: \(error)")
                    self.suggestions = []
                }
            }
        
        }
    
    func search(query: String) async throws -> [String]  {
       return try await FetchPantryIngredients().quaryIngredients(text: query)
    }
       
   
    func addPantry(sessionManager: SessionManager, item: String) {
        Task {
             self.httpResponseCode = try await AddPantry(sessionManager: sessionManager).addPantry(with: item)
             self.feedBack =  AddStatus(statusCode: httpResponseCode).description
             }
    }
    
    
    enum AddStatus {

        case success
        case conflict
        case other(Int)
        
        
        init(statusCode: Int) {
            switch statusCode {
            case 200:
                self = .success
            case 409:
                self = .conflict
            default:
                self = .other(statusCode)
            }
        }
        
        var description: String {
                switch self {
                case .success:
                    return "Item added to your pantry"
                case .conflict:
                    return "Already added item into pantry"
                case .other(let code):
                    return "Other status: \(code)"
                }
            }
        
    }
   
    
}

