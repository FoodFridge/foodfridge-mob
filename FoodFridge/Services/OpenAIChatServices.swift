//
//  OpenAIChatServices.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/4/24.
//

import Foundation
class OpenAIChatService {
    let apiKey: String
    let session: URLSession

    init(apiKey: String) {
        self.apiKey = apiKey
        self.session = URLSession(configuration: .default)
    }

    func sendMessage(_ message: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/completions")! // Use the correct URL for ChatGPT
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "prompt": message,
            "max_tokens": 150
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let responseDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let responseMessage = responseDict?["choices"] as? [[String: Any]]
            let text = responseMessage?.first?["text"] as? String
            completion(text)
        }

        task.resume()
    }
}
