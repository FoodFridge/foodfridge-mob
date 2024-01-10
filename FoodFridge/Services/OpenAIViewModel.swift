//
//  OpenAIViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/4/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    private let apiKey = "YOUR_API_KEY_HERE" // Replace with your actual API key
    private let baseURL = "https://api.openai.com/v1/engines/davinci-codex/completions"

    @Published var responseText: String = ""
    
    func sendRequest(prompt: String) {
        guard let url = URL(string: baseURL) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 50 // Adjust this as needed
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response) in
                self?.responseText = response.choices.first?.text ?? "No response"
            }
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []
}

struct Response: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
}

struct Usage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct Choice: Decodable {
    let text: String
    let finish_reason: String?
}
