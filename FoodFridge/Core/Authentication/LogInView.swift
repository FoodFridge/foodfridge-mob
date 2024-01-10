// Keaw test
// keaw test agian to confirm
//  LogInView.swift
//  FoodFridgec
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct LogInView: View {
    
       @ObservedObject var viewModel: ChatViewModel
       @State private var prompt = ""

       var body: some View {
           VStack {
               TextField("Enter a prompt", text: $prompt)
                   .padding()
                   .textFieldStyle(RoundedBorderTextFieldStyle())
               
               Button("Generate Response") {
                   viewModel.sendRequest(prompt: prompt)
               }
               .padding()
               
               Text(viewModel.responseText)
                   .padding()
           }
           .padding()
       }
    /*
    
        @State private var userInput: String = ""
        @State private var response: String = ""
        private let chatService = OpenAIChatService(apiKey: "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")

        var body: some View {
            VStack {
                TextField("Ask something...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    chatService.sendMessage(userInput) { text in
                        DispatchQueue.main.async {
                            response = text ?? "Error"
                        }
                    }
                }

                Text(response)
                    .padding()
            }
        }
     */
    
}

#Preview {
    LogInView(viewModel: ChatViewModel())
}
